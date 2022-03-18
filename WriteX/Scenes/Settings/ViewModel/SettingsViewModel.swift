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
    
    let isOnPublisher = CurrentValueSubject<Bool,Never>(false)
    var cancellable = Set<AnyCancellable>()
    var firebase: FirebaseWorker!
        
    init(){}
    
    
     //MARK: - Configure Switch
    func configureSwithISOnStateFromLocallyDatabase(){
        let stateOfMode = LocalDataManager.themeOfInterface()
        self.isOnPublisher.send(stateOfMode.uiInterfaceStyle == .dark)
    }
    
    
    
     //MARK: - Handel change of Switch isOn With Binding
    
    // 1
    func getStateOfDefaultModeFromDatabaseLocallyAndSetupPublisher(){
        let stateOfMode = LocalDataManager.themeOfInterface()
        isOnPublisher.send(stateOfMode.uiInterfaceStyle == .dark)
    }
    
    // 2
    func bindToChangeModeOfInterface(){
        getStateOfDefaultModeFromDatabaseLocallyAndSetupPublisher()
        isOnPublisher.receive(on: RunLoop.main)
            .sink { state in
                LocalDataManager.configureSystemStyle(theme: state == true ? .dark:.light)
                AppDelegate().overrideApplicationThemeStyle()
        }.store(in: &cancellable)
    }
    
   
    
    
    
    
    
    
    
     //MARK: - Setup User
    func configureLoginUser(){
        guard let user = LocalDataManager.getUsetOfLogin() else { return }
        self.userAuth = user
    }
    
    
    
    
     //MARK: - Clear Database
    func handelAllDataToBeNUll(){
        LocalDataManager.saveLoginUser(user: nil)
        LocalDataManager.saveNotesLocaly(nil)
        LocalDataManager.firstLoginApp(true)
    }
    
    
}
