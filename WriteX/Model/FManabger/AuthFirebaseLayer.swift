//
//  AuthFirebaseLayer.swift
//  VIPER-RXSwift
//
//  Created by Ahmed Fathy on 30/01/2022.
//

import Combine
import Firebase

protocol FirebaseAuth {
    func signIn(withEmail: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async  -> (AuthDataResult?, Error?)
    func signUp(withEmail: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async ->(AuthDataResult? , Error?)
    func write(data: NSDictionary, childIndex: Int)
    func read()
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
    
    
    func write(data: NSDictionary, childIndex: Int)  {
        guard let uid = LocalDataManager.getUser() else { return }
        self.ref.child(KNOTECHILD).child(uid).child("\(childIndex)").setValue(data) { error, _ in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            
        }
        
    }
    
    func read(){
        guard let uid = LocalDataManager.getUser() else { return }
        self.ref.child(KNOTECHILD).child(uid).getData { error, snapshot  in
            if let value = snapshot.value as? NSDictionary {
                let notes: [Note] = [.init(dictionary: value as! [String : Any])]
                print(notes)
                
            }else {
                print("Error to get Data ")
            }
        }
    }

}


