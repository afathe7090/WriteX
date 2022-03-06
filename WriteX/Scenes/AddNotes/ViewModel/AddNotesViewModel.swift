//
//  AddNotesVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import Foundation
import Combine


class AddNotesViewModel {
    
    
    var note = CurrentValueSubject<Note?,Never>(nil)
    let titleNote = CurrentValueSubject<String,Never>("")
    let discriptionNote = CurrentValueSubject<String,Never>("")
    
    
     //MARK: - Init
    init(){}
    
    
     //MARK: - Helper Functions
    
    
    func confirmNotes()-> Note? {
        guard titleNote.value != "" , discriptionNote.value != "" else { return nil }
        let note = Note(title: titleNote.value
                        , description: discriptionNote.value
                        , date: getCurrentData())
        return note
    }
    
}
