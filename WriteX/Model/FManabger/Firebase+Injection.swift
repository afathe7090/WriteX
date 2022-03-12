//
//  Firebase+Injection.swift
//  Swinject_Project
//
//  Created by Ahmed Fathy on 08/02/2022.
//

import Foundation
import Swinject

extension Container {
    func firebaseDependencyInjectionContainer(){
        
        register(FirebaseAuth.self) { r in
            return FirebaseAuthLayer()
        }
        
        register(FirebaseWorker.self) { (resolver) in
            let firebaseWorker = FirebaseWorker()
            firebaseWorker.authLayer =  resolver.resolve(FirebaseAuth.self)
            return firebaseWorker
        }
    }
}
