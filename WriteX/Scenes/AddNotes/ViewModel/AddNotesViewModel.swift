//
//  AddNotesVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import Foundation
import Combine


class AddNotesViewModel {
    
    @Published var indexNote: Int = 0
    var note = CurrentValueSubject<Note?,Never>(nil)
    let titleNote = CurrentValueSubject<String,Never>("")
    let discriptionNote = CurrentValueSubject<String,Never>("")
    
    
     //MARK: - Init
    init(){}
    
    
     //MARK: - Helper Functions
    
    
    func confirmNotes()-> Note {
//         titleNote.value != "" , discriptionNote.value != "" 
        let note = Note(title: titleNote.value
                        , description: discriptionNote.value
                        , date: getCurrentData())
        return note
    }
    
}
