//
//  LocalDataManager.swift
//  WriteX
//
//  Created by Ahmed Fathy on 12/03/2022.
//

import UIKit

class LocalDataManager {
    
    class func saveLoginUser(user: LoginUser){
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
    
    
    
    class func saveNotesLocaly(_ note: [Note]){
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
    
    
    class func firstLoginApp(_ state: Bool = false){
        defaults.set(state, forKey: kFIRSTLOGIN)
        defaults.synchronize()
    }
    
    class func isFirstLogin()-> Bool {
        return defaults.bool(forKey: kFIRSTLOGIN)
    }
    
}
