//
//  HelperFunctions.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import Foundation


func getCurrentData()-> String{
    let date = Date()
    let dateFormater = DateFormatter()
    dateFormater.dateStyle = .long
    dateFormater.timeStyle = .short
    return dateFormater.string(from: date)
}


func saveNotesLocaly(_ note: [Note]){
    let encoder = JSONEncoder()
    do{
        let data = try encoder.encode(note)
        defaults.set(data, forKey: kNOTES)
        defaults.synchronize()
    }catch {
        print(error.localizedDescription)
    }
}

func getNotesLocaly()-> [Note]? {
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
