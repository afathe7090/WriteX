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
    @Published var notesPublisher = [Note]()
    @Published var filterPublisher = [Note]()
    @Published var edittingNote: Note? = nil
    
    private var cancelable = Set<AnyCancellable>()
    
    var firebase: FirebaseWorker!

    init(){ }
    
   
    
    func getNotesLocalley(){
        guard let notes = getNotesLocaly() else { return }
        notesPublisher = notes
    }
    
    // Search View Controller Handelr Search
    func filterNotesBy(searchText: String){
        $notesPublisher
            .map { $0.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            }.sink { notes in
                self.filterPublisher = notes
            }.store(in: &cancelable)
    }
    
    
    func setEdittingOrAddingNote(_ note: Note){
        if isEditting { notesPublisher.remove(element: edittingNote!)}
        notesPublisher.insert(note, at: 0)
        saveNotesLocaly(notesPublisher)
    }
    
}

