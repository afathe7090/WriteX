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
    
    var firebase: FirebaseWorker!
    
    init(){ }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    
    func numberOfRows()-> Int{
        return searchBarActive == false ? notesPublisher.map({$0.isHidden == false}).count + 1:filterPublisher.map({$0.isHidden == false}).count
    }
    
    // Setup Notes Cells
    func setUpNotesCell(_ cell : NotesCell, indexPath: IndexPath){
        let note = searchBarActive == true ? filterPublisher[indexPath.row]:notesPublisher[indexPath.row - 1]
        cell.setCell(note)
    }
    
    func presentedNote(indexPath: IndexPath)->Note {
        isEditting = true
        let note = searchBarActive == true ? filterPublisher[indexPath.row]:notesPublisher[indexPath.row - 1]
        edittingNote = note
        return note
    }
    
    
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

