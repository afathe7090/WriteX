//
//  Notes.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import Foundation


struct Note: Codable, Equatable{
//    var id          = UUID()
    let title       : String
    let discription : String
    let date        : String
    var isHidden    = false
    
    
    init(dictionary: [String: Any]){
        self.title = dictionary[kTITLE] as? String ?? ""
        self.discription = dictionary[kDISCRIPTION] as? String ?? ""
        self.date = dictionary[kDATE] as? String ?? ""
        self.isHidden = dictionary[kHIDDEN] as? Bool ?? false
    }
    
    
    
    init(title: String,discription: String, date : String){
        self.title = title
        self.discription = discription
        self.date = date
        
    }
}
