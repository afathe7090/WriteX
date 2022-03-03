//
//  RegisterAllContainer.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import Swinject

extension Container {
    
    public func registerAllContainer(){
        loginVCDependancyInject()
        
        registerDIContainer()
        
        forgetDIContainer()
        
        firebaseDependencyInjectionContainer()
        
    }
    
}
