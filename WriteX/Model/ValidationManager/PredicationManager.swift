//
//  PredicationManager.swift
//  Validation_Combine
//
//  Created by Ahmed Fathy on 19/02/2022.
//

import Foundation

enum SecurePasswordType{
    case notSecure
    case weakSecure
    case mediumSecure
    case strongSecure
}


protocol PredicateProtocol{
    func predicateTypeOfStr(_ str: String)-> SecurePasswordType
    func predicateEmail(str: String)-> Bool 
}

class PredicateManager: PredicateProtocol {
    
    enum PredicateState{
        
        static let emailPredicate      = NSPredicate(format:"SELF MATCHES %@",
                                                     "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        
        static let weakPredicate       =  NSPredicate(format: "SELF MATCHES %@",
                                                     "^(?=.*[a-z])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        static  let mediumPredicate    =  NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        static let strongPredeicate    = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8,}$")
    }
    
    
    /// Validate Password type of Secure
    /// - Parameter str: Password String
    /// - Returns: Return kind of password
    func predicateTypeOfStr(_ str: String)-> SecurePasswordType {
        
        //    1 - Password length is 8.
        //    2 - 2 UpperCase letters in Password.
        //    3 - One Special Character in Password.
        //    4 - Two Number in Password.
        //    5- Three letters of lowercase in password.
        if PredicateState.strongPredeicate.evaluate(with: str){
            return .strongSecure
        }else if PredicateState.mediumPredicate.evaluate(with: str){
            //    1 - Password length is 8.
            //    2 - One Alphabet in Password.
            //    3 - One Special Character in Password.
            return .mediumSecure
        }else if PredicateState.weakPredicate.evaluate(with: str) {
            //    1 - Password length is 8.
            //    2 - One Alphabet in Password.
            
            return .weakSecure
        }else {
            // not valid or not secure
            return .notSecure
        }
        
    }
    
    func predicateEmail(str: String)-> Bool {
        return PredicateState.emailPredicate.evaluate(with: str)
    }
    
}
