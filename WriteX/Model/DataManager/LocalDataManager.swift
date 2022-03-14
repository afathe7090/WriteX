//
//  LocalDataManager.swift
//  WriteX
//
//  Created by Ahmed Fathy on 12/03/2022.
//

import UIKit

class LocalDataManager {
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  save user of data when login
    // WE Will need it to present email as String and password to valid hiden Notes
    //----------------------------------------------------------------------------------------------------------------
    class func saveLoginUser(user: LoginUser?){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(user)
            defaults.set(data, forKey: kUSERDEFAULTS)
            defaults.synchronize()
        }catch {
            print(error.localizedDescription)
        }
    }
        
    class func getUsetOfLogin()-> LoginUser?{
        var userAuth: LoginUser?
        if let data = defaults.data(forKey: kUSERDEFAULTS) {
            let decoder = JSONDecoder()
            
            do{
                let authUser = try decoder.decode(LoginUser.self, from: data)
                userAuth = authUser
            }catch{
                print(error.localizedDescription)
            }
        }
        return userAuth
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Save and work with the Locally of Notes
    //----------------------------------------------------------------------------------------------------------------
    class func saveNotesLocaly(_ note: [Note]?){
        let encoder = JSONEncoder()
        do{
            let data = try encoder.encode(note)
            defaults.set(data, forKey: kNOTES)
            defaults.synchronize()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    
    class func getNotesLocaly()-> [Note]? {
        var notes: [Note]?
        if let data = defaults.data(forKey: kNOTES) {
            let decoder = JSONDecoder()
            
            do{
                let noteDecoder = try decoder.decode([Note].self, from: data)
                notes = noteDecoder
            }catch{
                print(error.localizedDescription)
            }
        }
        return notes
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Handel is First Login to read all data for user from firebase
    //----------------------------------------------------------------------------------------------------------------
    class func firstLoginApp(_ state: Bool = false){
        defaults.set(state, forKey: kFIRSTLOGIN)
        defaults.synchronize()
    }
    
    class func isFirstLogin()-> Bool {
        return defaults.bool(forKey: kFIRSTLOGIN)
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Handel DarkMode
    //----------------------------------------------------------------------------------------------------------------
    class func configureSystemStyle(theme: Theme) {
        defaults.set(theme.rawValue, forKey: kDARKMODE)
        defaults.synchronize()
    }
    
    class func themeOfInterface()-> Theme {
        guard let rowValue = defaults.string(forKey: kDARKMODE) else { return .light }
        guard let theme = Theme(rawValue: rowValue) else { fatalError() }
        return theme
    }
    
}
