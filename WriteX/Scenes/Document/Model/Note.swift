//
//  Notes.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import Foundation


struct Note: Codable, Equatable, Hashable{
    var id          = UUID()
    let title       : String
    let description : String
    let date        : String
    var isHidden    = false
}