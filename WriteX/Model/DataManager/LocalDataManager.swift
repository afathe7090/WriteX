//
//  LocalDataManager.swift
//  WriteX
//
//  Created by Ahmed Fathy on 12/03/2022.
//

import UIKit

class LocalDataManager {
    
    class func saveUID(_ uuid: String){
        defaults.set(uuid, forKey: kUID)
        defaults.synchronize()
    }
    
    class func getUser()-> String? {
        return defaults.string(forKey: kUID)
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
    
    
    
    
}
