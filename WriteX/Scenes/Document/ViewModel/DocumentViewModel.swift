//
//  DocumentViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import Foundation
import Combine

class DocumentViewModel {
    
    @Published var isEditting = false
    
    var notesPublisher = CurrentValueSubject<[Note],Never>([Note]())
    var filterPublisher = CurrentValueSubject<[Note],Never>([Note]())
    
    private var cancelable = Set<AnyCancellable>()
    
    var firebase: FirebaseWorker!

    init(){}
    
    func handelDataBackLocally(){
        guard let notes = getNotesLocaly() else { return }
        notesPublisher.send(notes)
    }
    
    func handelDataLocaly(){
        notesPublisher.sink { notes in
            saveNotesLocaly(notes)
        }.store(in: &cancelable)
    }
    
}

