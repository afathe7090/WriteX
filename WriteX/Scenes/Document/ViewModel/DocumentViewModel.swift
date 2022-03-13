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
    @Published var isHiddenNotes        = true
    
    
    let searchBarPublisher              = PassthroughSubject<String,Never>()
    let reloadCollectionView            = PassthroughSubject<Bool,Never>()
    
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
        return searchBarActive == false ? notesPublisher.filter({$0.isHidden == isHiddenNotes}).count + 1:filterPublisher.filter({$0.isHidden == isHiddenNotes}).count
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
        let note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index]
        notesPublisher.remove(element: note)

        let noteHidden = Note(title: note.title, discription: note.discription, date: note.date, isHidden: true)
        notesPublisher.append(noteHidden)
        
        firebase.deleteAll()
        writeNotesToFirebase()
        reloadCollectionView.send(true)
    }
    
    
    // Action Of Reomve Selected Button
    func removeNoteSelectedBy(_ index: Int) {
        let note = searchBarActive == true ? filterPublisher[index]:notesPublisher[index]
        notesPublisher.remove(element: note)
        firebase.deleteAll()
        writeNotesToFirebase()
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
        reloadCollectionView.send(true)
        writeNotesToFirebase()
    }
    
    
    //MARK: - Firebase Worker
    
    func setDataNotes(){
        getNotesLocalley()
        writeNoteToFirebase()
        if LocalDataManager.isFirstLogin() == true { readNotes() }
        reloadCollectionView.send(true)
    }
    
    
    // Save Data in defaults
    func getNotesLocalley(){
        guard let notes = LocalDataManager.getNotesLocaly() else { return }
        notesPublisher = notes
        reloadCollectionView.send(true)
    }
    
  
    
    // Save Notes in Database
    func writeNoteToFirebase(){
        $notesPublisher.sink { notes in
            LocalDataManager.saveNotesLocaly(notes)
        }.store(in: &cancelable)
    }
    
    func writeNotesToFirebase(){
        guard let notesDataLocaly = LocalDataManager.getNotesLocaly() else { return }
        notesDataLocaly.forEach { note in
            firebase.write(data: noteAsDictionary(note: note),indexNote: notesPublisher.firstIndex(of: note) ?? 0)
        }
    }
    
    func updateNotesFirebase(note: Note , index: Int){
        firebase.update(data: noteAsDictionary(note: note),childIndex: index)
    }
    
    func delete(index: Int){
        firebase.delete(index: index)
    }
    
    
    
    
    // read data from firebase
    // Note this call in just oneA
    func readNotes(){
        Task{
            guard let notes = await firebase.read() else{ return }
            self.notesPublisher = notes
            self.reloadCollectionView.send(true)
        }
    }
    
}
