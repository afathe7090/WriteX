//
//  RegisterViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Foundation
import Combine

class RegisterViewModel{
    
    
    let emailPublisher                    = CurrentValueSubject<String,Never>("")
    let passwordPublisher                 = CurrentValueSubject<String,Never>("")
    let confirmPasswordPublisher          = CurrentValueSubject<String,Never>("")
    
    let animationEmailPublisher           = CurrentValueSubject<Bool, Never>(false)
    let animationaPassPublisher           = CurrentValueSubject<Bool, Never>(false)
    let animationConfirmPasswordPublisher = CurrentValueSubject<Bool,Never>(false)
    
    var firebase: FirebaseWorker!
    var cancelable = Set<AnyCancellable>()
    
    
    //MARK: - protocls
    private var validation: ValidationManager{
        return ValidationPublisher()
    }
    
    private var predicate: PredicateProtocol {
        return PredicateManager()
    }
    
    //MARK: - Register
    
    func signUp(){
        Task{
            let (_, error) = await firebase.signUp(email: emailPublisher, password: passwordPublisher)
            if let error = error {
                print(error)
                await checkValidationOfEmail()
                await checkValidationOfPassword()
                await checkValidationOfConfirmPassword()
            }
        }
    }
    
    
    //MARK: - Set Animations
    func configureValidation() {
        Task{
            await checkValidationOfEmail()
            await checkValidationOfPassword()
            await checkValidationOfConfirmPassword()
            
        }
    }
    
    func checkValidationOfEmail() async {
        let state = predicate.predicateEmail(str: emailPublisher.value)
        animationEmailPublisher.send(!state)
    }
    
    func checkValidationOfPassword() async {
        let state = passwordPublisher.value.count >= 8
        animationaPassPublisher.send(!state)
    }
    
    func checkValidationOfConfirmPassword() async {
        let state = passwordPublisher.value.count >= 8  && confirmPasswordPublisher.value == passwordPublisher.value
        animationConfirmPasswordPublisher.send(!state)
    }
    
    
}
