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
