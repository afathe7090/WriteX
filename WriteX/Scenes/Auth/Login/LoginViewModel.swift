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
enum AnimationShanke{
    case email
    case password
}


class LoginViewModel {
    
    let emailPublisher = CurrentValueSubject<String,Never>("")
    let passwordPublisher = CurrentValueSubject<String,Never>("")
    
    let presentPublisher = PassthroughSubject<loginPresentCases,Never>()
    
    
    let animationEmailPublisher = CurrentValueSubject<Bool, Never>(false)
    let animationaPassPublisher = CurrentValueSubject<Bool, Never>(false)
    
    var firebase: FirebaseWorker!
    var cancelable = Set<AnyCancellable>()
    
    private var validation: ValidationManager{
        return ValidationPublisher()
    }
    
    private var predicate: PredicateProtocol {
        return PredicateManager()
    }
    
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
    
    
    //MARK: - Set Animations
    func configureValidation(){
        checkValidationOfEmail()
        checkValidationOfPassword()
    }
    
    func checkValidationOfEmail(){
        let state = predicate.predicateEmail(str: emailPublisher.value)
        animationEmailPublisher.send(!state)
    }
    
    func checkValidationOfPassword(){
        let secureType = passwordPublisher.value.count >= 8
        animationaPassPublisher.send(!secureType)
    }
    
    
    func changeStateOfLogin()-> AnyPublisher<Bool, Never>{
        return Publishers.CombineLatest(validation.checkEmailValidPublisher(emailPublisher),
                                 validation.checkTextIsValidPublisher(passwordPublisher)).map { (emailState , passState) in
            return passState && emailState
        }.eraseToAnyPublisher()
    }
    
}
