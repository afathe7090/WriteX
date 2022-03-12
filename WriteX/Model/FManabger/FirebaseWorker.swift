//
//  FirebaseWorker.swift
//  VIPER-RXSwift
//
//  Created by Ahmed Fathy on 30/01/2022.
//
//
import Firebase
import UIKit
import Combine

class FirebaseWorker{
    
    var authLayer: FirebaseAuth!
    
    func signIn(email: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async ->(AuthDataResult? , Error?){
        return await authLayer.signIn(withEmail: email, password: password)
    }
    
    func signUp(email: CurrentValueSubject<String,Never>
                , password: CurrentValueSubject<String,Never>) async -> (AuthDataResult? , Error?) {
        return await authLayer.signUp(withEmail: email, password: password)
    }
    
    func write(data: NSDictionary,childIndex: Int?) {
        guard let childIndex = childIndex else { return }

        authLayer.write(data: data, childIndex: childIndex)
    }
    
    func read() async -> [Note]?{
        
        
        // NOTE Handel SnapShot
        do{
            let (error, snapshot)  = try await authLayer.read()
            if error != nil { return  nil }
            return (handelReturnNotes(snapshot: snapshot))
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private func handelReturnNotes(snapshot: DataSnapshot)-> [Note]? {
        var notes = [Note]()
        let value = snapshot.value as? NSArray
        for index in 0..<(value?.count ?? 1) {
            let user = value?[index] as? NSDictionary
            let note = Note(dictionary: user as! [String : Any])
            notes.insert(note, at: index)
            //            print(notes)
        }
        return notes
    }
}
