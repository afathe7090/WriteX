//
//  Register+Injection.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Foundation
import Swinject

extension Container {
    public func registerDIContainer(){
        
        register(RegisterViewModel.self) { resolver in
            let viewModel = RegisterViewModel()
            viewModel.firebase = resolver.resolve(FirebaseWorker.self)
            return viewModel
        }
        
        register(RegisterVC.self) { (resolver) in
            let registerVC = RegisterVC()
            registerVC.viewModel = container.resolve(RegisterViewModel.self)
            return registerVC
        }
        
    }
}
