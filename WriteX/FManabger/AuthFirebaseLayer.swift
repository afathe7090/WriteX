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
}

class FirebaseAuthLayer: FirebaseAuth {
    
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
    
}
