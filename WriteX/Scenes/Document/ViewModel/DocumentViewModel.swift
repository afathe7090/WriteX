//
//  DocumentViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import Foundation
import Combine

class DocumentViewModel {
    
    @Published var isEditting           = false
    @Published var notesPublisher       = [Note]()
    @Published var filterPublisher      = [Note]()
    @Published var edittingNote: Note?  = nil
    @Published var searchBarActive      = false
    let searchBarPublisher              = PassthroughSubject<String,Never>()
    
    
    private var cancelable              = Set<AnyCancellable>()
    
    
    // Firebase
    var firebase: FirebaseWorker!
    
    
    // Init
    init(){ }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    // nUmber of Rows after Filter
    func numberOfRows()-> Int{
        return searchBarActive == false ? notesPublisher.filter({$0.isHidden == false}).count + 1:filterPublisher.filter({$0.isHidden == false}).count
    }
    
    // Setup Notes Cells
    func setUpNotesCell(_ cell : NotesCell, index: Int){
        let note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index - 1]
        cell.menuButtonCell.tag = searchBarActive == true ? index:index - 1
        cell.setCell(note)
        
    }
    
    // Note that will be editting
    func presentedNote(index: Int)->Note {
        isEditting = true
        let note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index - 1]
        edittingNote = note
        return note
    }
    
    
    //hiden Notes That Selected
    func hidenNoteSelectedBy(_ index: Int){
        var note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index]
        notesPublisher.remove(element: note)
        note.isHidden = true
        notesPublisher.insert(note, at: 0)
        saveNotesLocaly(notesPublisher)
    }
    
    
    
    // Action Of Reomve Selected Button
    func removeNoteSelectedBy(_ index: Int) {
        let note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index]
        notesPublisher.remove(element: note)
        saveNotesLocaly(notesPublisher)
    }
    
    
    // Save Data in defaults
    func getNotesLocalley(){
        guard let notes = getNotesLocaly() else { return }
        notesPublisher = notes
    }
    
    // Search View Controller Handelr Search
    func filterNotesBy(){
        Publishers.CombineLatest($notesPublisher, searchBarPublisher).map { (notes, searchText) in
            notes.filter { $0.title.lowercased().contains(searchText.lowercased())}
        }.sink { notes in
            self.filterPublisher = notes
        }.store(in: &cancelable)
        
    }
    
    // Edit Array of saved Data
    func setEdittingOrAddingNote(_ note: Note){
        if isEditting { notesPublisher.remove(element: edittingNote!)}
        notesPublisher.insert(note, at: 0)
        saveNotesLocaly(notesPublisher)
    }
    
}

