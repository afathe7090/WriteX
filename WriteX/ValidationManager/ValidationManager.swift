//
//  ValidationManager.swift
//  Validation_Combine
//
//  Created by Ahmed Fathy on 19/02/2022.
//

import Foundation
import Combine


protocol ValidationManager{
    func checkEmailValidPublisher(_ txt: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>
    func checkEmailValidPublisher(_ txt: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>
    
    func checkTextIsValidPublisher(_ txt: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>
    func checkTextIsValidPublisher(_ txt: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>
    func checkValidtionOfEqualPublisher(_ txt1: PassthroughSubject<String,Never>,
                                        _ txt2: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>
    func checkValidtionOfEqualPublisher(_ txt1: CurrentValueSubject<String,Never>,
                                        _ txt2: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>
    func isPasswordSecureValidPublisher(_ password: CurrentValueSubject<String,Never>)-> AnyPublisher<SecurePasswordType,Never>
    func isPasswordSecureValidPublisher(_ password: PassthroughSubject<String,Never>)-> AnyPublisher<SecurePasswordType,Never>
}

class ValidationPublisher: ValidationManager{
    
    private var predecation: PredicateProtocol {
        return PredicateManager()
    }
    
    func checkEmailValidPublisher(_ txt: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return txt.map({ str in
            return self.predecation.predicateEmail(str: str)
        }).eraseToAnyPublisher()
    }
    
    
    func checkEmailValidPublisher(_ txt: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return txt.map({ str in
            return self.predecation.predicateEmail(str: str)
        }).eraseToAnyPublisher()
    }
    
    
    /// Check password that have at least 8 char
    /// - Parameter txt: password Subject (CurrentValueSubject)
    /// - Returns: Publisher of Bool
    func checkTextIsValidPublisher(_ txt: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return txt.map({ txt in
            return txt.count >= 8
        }).eraseToAnyPublisher()
    }
    
    
    
    /// Check password that have at least 8 char
    /// - Parameter txt: password Subject  (PassthroughSubject)
    /// - Returns: Publisher of Bool
    func checkTextIsValidPublisher(_ txt: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return txt.map({ txt in
            return txt.count >= 8
        }).eraseToAnyPublisher()
    }
    
    
    
    /// Check if the pass and re_password is Equal
    /// - Parameters:
    ///   - txt1: Txt1 string of (PassthroughSubject)
    ///   - txt2: Txt2 string of (PassthroughSubject)
    /// - Returns: Publisher of Bool that if two txt is Equal
    func checkValidtionOfEqualPublisher(_ txt1: PassthroughSubject<String,Never>,
                                        _ txt2: PassthroughSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest(txt1 , txt2).map({ fText , sText in
            return fText == sText
        }).eraseToAnyPublisher()
    }
    
    
    /// Check if the pass and re_password is Equal
    /// - Parameters:
    ///   - txt1: Txt1 string of (CurrentValueSubject)
    ///   - txt2: Txt2 string of (CurrentValueSubject)
    /// - Returns: Publisher of Bool that if two txt is Equal
    func checkValidtionOfEqualPublisher(_ txt1: CurrentValueSubject<String,Never>,
                                        _ txt2: CurrentValueSubject<String,Never>)-> AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest(txt1 , txt2).map({ fText , sText in
            return fText == sText
        }).eraseToAnyPublisher()
    }
    
    
    
    /// Check Password type of Protection
    /// - Parameter password: Password (CurrentValueSubject)
    /// - Returns: Publisher of statues of secure password
    func isPasswordSecureValidPublisher(_ password: CurrentValueSubject<String,Never>)-> AnyPublisher<SecurePasswordType,Never>{
        return password.map { str in
            return self.predecation.predicateTypeOfStr(str)
        }.eraseToAnyPublisher()
    }
    
    
    /// Check Password type of Protection
    /// - Parameter password: Password (PassthroughSubject)
    /// - Returns: Publisher of statues of secure password
    func isPasswordSecureValidPublisher(_ password: PassthroughSubject<String,Never>)-> AnyPublisher<SecurePasswordType,Never>{
        return password.map {str in
            return self.predecation.predicateTypeOfStr(str)
        }.eraseToAnyPublisher()
    }
    
}
