//
//  BaseDI.swift
//  WriteX
//
//  Created by Ahmed Fathy on 12/03/2022.
//

import Foundation
import Swinject

extension Container {
    
    public func baseTabBarContainer(){
        
        register(BaseTabBar.self) { _ in
            BaseTabBar()
        }
    }
}
