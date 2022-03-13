//
//  SettingsViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import Foundation
import Combine


class SettingsViewModel{
    
    @Published var constantCellData = ["","","",""]
    @Published var userAuth: LoginUser!
    
    var firebase: FirebaseWorker!
        
    init(){}
    
    
    func configureLoginUser(){
        guard let user = LocalDataManager.getUsetOfLogin() else { return }
        self.userAuth = user
    }
    
}
