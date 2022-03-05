//
//  Settings+Inject.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Swinject

extension Container {
    public func settingDIContainer(){
        
        register(SettingsViewModel.self) { resolver in
            let viewModel = SettingsViewModel()
            viewModel.firebase = resolver.resolve(FirebaseWorker.self)
            return viewModel
        }
        
        
        register(SettingsVC.self) { resolver in
            let settingVC = SettingsVC()
            settingVC.viewModel = resolver.resolve(SettingsViewModel.self)
            return settingVC
        }
        
    }
}
