//
//  AuthFirebaseLayer.swift
//  VIPER-RXSwift
//
//  Created by Ahmed Fathy on 30/01/2022.
//

import Combine
import Firebase

enum ERROR_READING: Error {
    case uid_Not_Found
}

protocol FirebaseAuth {
    func signIn(withEmail: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async  -> (AuthDataResult?, Error?)
    func signUp(withEmail: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async ->(AuthDataResult? , Error?)
    func write(data: NSDictionary, indexNote: Int)
    func read() async throws -> (Error? , DataSnapshot)
    func update(data: NSDictionary ,childIndex: Int)
    func delete(index: Int)
}

class FirebaseAuthLayer: FirebaseAuth {
    
    var ref = Database.database().reference()
    
    
    func signIn(withEmail: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async  -> (AuthDataResult?, Error?){
        return await withCheckedContinuation({ continuation in
            Auth.auth().signIn(withEmail: withEmail.value, password: password.value) { result, error in
                continuation.resume(returning: (result,error))
            }
        })
    }
    
    func signUp(withEmail: CurrentValueSubject<String,Never>,
                password: CurrentValueSubject<String,Never>) async ->(AuthDataResult? , Error?){
        return await withCheckedContinuation({ continuation in
            Auth.auth().createUser(withEmail: withEmail.value, password: password.value) { result, error in
                continuation.resume(returning: (result, error))
            }
        })
    }
    
    
    func write(data: NSDictionary, indexNote: Int)  {
        guard let uid = LocalDataManager.getUsetOfLogin()?.curentId else { return }
        ref.child(KNOTECHILD).child(uid).child("\(indexNote)").setValue(data) { error, _ in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func delete(index: Int){
        guard let uid = LocalDataManager.getUsetOfLogin()?.curentId else { return }
        self.ref.child(KNOTECHILD).child(uid).child("\(index)").removeValue()
    }
    
    
    
    func update(data: NSDictionary ,childIndex: Int){
        guard let uid = LocalDataManager.getUsetOfLogin()?.curentId else { return }
        self.ref.child(KNOTECHILD).child(uid).child("\(childIndex)").updateChildValues(data as! [AnyHashable : Any])
    }
    
    func read() async  -> (Error? , DataSnapshot){
        return await withCheckedContinuation({ continuation in
            if let uid = LocalDataManager.getUsetOfLogin()?.curentId {
                self.ref.child(KNOTECHILD).child(uid).getData { (error, snapshot)  in
                    continuation.resume(returning: (error, snapshot))
                }
            }
        })
        
    }
    
    
    func signOut(){
        // NOTE:- Don't
        LocalDataManager.firstLoginApp(false)
    }
}

