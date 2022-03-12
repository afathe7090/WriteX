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
    
    func write(data: NSDictionary,childIndex: Int) {
        authLayer.write(data: data, childIndex: childIndex)
    }
    
    func read() async {
      
        
        // NOTE Handel SnapShot
        
//        let value = snapshot.value as? NSArray
//        for index in 0..<(value?.count ?? 1) {
//            guard let user = value?[index] as? NSDictionary else { return }
//            let notes = Note(dictionary: user as! [String : Any])
//            print(notes)
//        }
    }
}
