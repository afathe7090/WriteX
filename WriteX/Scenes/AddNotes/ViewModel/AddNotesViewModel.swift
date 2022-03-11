//
//  AddNotesVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import Foundation
import Combine


class AddNotesViewModel {
    
    @Published var stateOfView: StateOfAddNote = .add
    @Published var note: Note!
    
    let titleNote = CurrentValueSubject<String,Never>("")
    let discriptionNote = CurrentValueSubject<String,Never>("")
    
    
     //MARK: - Init
    init(){}
    
     //MARK: - Helper Functions

    
}
