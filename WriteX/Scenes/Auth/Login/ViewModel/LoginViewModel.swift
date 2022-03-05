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
    
    let emailPublisher              = CurrentValueSubject<String,Never>("")
    let passwordPublisher           = CurrentValueSubject<String,Never>("")
    
    let presentPublisher            = PassthroughSubject<loginPresentCases,Never>()
    
    let animationEmailPublisher     = CurrentValueSubject<Bool, Never>(false)
    let animationaPassPublisher     = CurrentValueSubject<Bool, Never>(false)
    
    var firebase: FirebaseWorker!
    var cancelable = Set<AnyCancellable>()
    
    
     //MARK: - protocls
    private var validation: ValidationManager{
        return ValidationPublisher()
    }
    
    private var predicate: PredicateProtocol {
        return PredicateManager()
    }
    
    
     //MARK: - Init
    init(){}
    
    
     //MARK: - Sign in
    func signIn(){
        Task{
            let (_, error) = await firebase.signIn(email: emailPublisher, password: passwordPublisher)
            if let error = error {
                print(error)
                await checkValidationOfEmail()
                await checkValidationOfPassword()
            }else{ presentPublisher.send(.home) }
        }
    }
    
    
    //MARK: - Set Animations
    func configureValidation() {
        Task{
           await checkValidationOfEmail()
           await checkValidationOfPassword()
        }
    }
    
    func checkValidationOfEmail() async {
        let state = predicate.predicateEmail(str: emailPublisher.value)
        animationEmailPublisher.send(!state)
    }
    
    func checkValidationOfPassword() async {
        let secureType = passwordPublisher.value.count >= 8
        animationaPassPublisher.send(!secureType)
    }
    
    
    
}
