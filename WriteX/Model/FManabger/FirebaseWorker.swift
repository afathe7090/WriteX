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
    
    func write(data: NSDictionary, indexNote: Int) {
        authLayer.write(data: data, indexNote: indexNote )
    }
    
    func update(data: NSDictionary,childIndex: Int){
        authLayer.update(data: data ,childIndex: childIndex)
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
    
    
    
    func delete(index: Int){
        authLayer.delete(index: index)
    }
    
    
    
    
    private func handelReturnNotes(snapshot: DataSnapshot)-> [Note]? {
        var notes = [Note]()
        guard let value = snapshot.value as? NSArray else { return nil}
        for index in 0..<(value.count ) {
            let user = value[index] as? NSDictionary
            let note = Note(dictionary: user as! [String : Any])
            notes.insert(note, at: index)
        }
        return notes
    }
}
