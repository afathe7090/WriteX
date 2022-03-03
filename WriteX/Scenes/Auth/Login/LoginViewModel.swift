//
//  LoginViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Foundation
import Combine

enum loginPresentCases{
    case home
}


class LoginViewModel {
//    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPublisher = CurrentValueSubject<String,Never>("")
    let passwordPublisher = CurrentValueSubject<String,Never>("")
    let presentPublisher = PassthroughSubject<loginPresentCases,Never>()
    
    var firebase: FirebaseWorker!
    
    init(){}
    
    func signIn(){
        Task{
            let (_, error) = await firebase.signIn(email: emailPublisher, password: passwordPublisher)
            if let error = error {
                // print error
                print(error)
            }else{
                // go to home
                print("Success to login ")
                presentPublisher.send(.home)
            }
        }
    }
    
}
