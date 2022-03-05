//
//  Login+Injection.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Foundation
import Swinject

extension Container {
    
    public func loginVCDependancyInject(){
        
        register(LoginViewModel.self) { resolver in
           let viewModel = LoginViewModel()
            viewModel.firebase = resolver.resolve(FirebaseWorker.self)
            return viewModel
        }
        
        register(LoginVC.self) { resolver in
            let vc = LoginVC()
            vc.viewModel = resolver.resolve(LoginViewModel.self)
            return vc
        }
    }
    
}
