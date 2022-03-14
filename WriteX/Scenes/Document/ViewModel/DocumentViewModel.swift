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
    @Published var isHiddenNotes        = false
    
    
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
        let note = searchBarActive == true ? filterPublisher.filter({$0.isHidden == isHiddenNotes})[index]:notesPublisher.filter({$0.isHidden == isHiddenNotes})[index - 1]
        cell.menuButtonCell.tag = searchBarActive == true ? index:index - 1
        cell.setCell(note)
    }
    
    // Note that will be editting
    func presentedNote(index: Int)->Note {
        isEditting = true
        let note = searchBarActive == true ? filterPublisher.filter({$0.isHidden == isHiddenNotes})[index]:notesPublisher.filter({$0.isHidden == isHiddenNotes})[index - 1]
        edittingNote = note
        return note
    }
    
    
    //hiden Notes That Selected
    func hidenNoteSelectedBy(_ index: Int){
        print(index)
        var note = searchBarActive == true ? filterPublisher.filter({$0.isHidden == isHiddenNotes})[index]:notesPublisher.filter({$0.isHidden == isHiddenNotes})[index]
        notesPublisher.remove(element: note)
        note.isHidden = !note.isHidden
        notesPublisher.append(note)
        
        firebase.delete(index: index)
        localDataManagerWithWriteToFirebaseToUpdateIndexs()
        
        
    }
    
    
    // Action Of Reomve Selected Button
    func removeNoteSelectedBy(_ index: Int) {
        let note = searchBarActive == true ? filterPublisher.filter({$0.isHidden == isHiddenNotes})[index]:notesPublisher.filter({$0.isHidden == isHiddenNotes})[index]
        deleteAll()
        notesPublisher.remove(element: note)
        
        localDataManagerWithWriteToFirebaseToUpdateIndexs()
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
        localDataManagerWithWriteToFirebaseToUpdateIndexs()
    }
    
    func localDataManagerWithWriteToFirebaseToUpdateIndexs(){
        LocalDataManager.saveNotesLocaly(notesPublisher)
        writeNotesToFirebase()
        reloadCollectionView.send(true)
    }
    
    
    //MARK: - Firebase Worker
    
    func setDataNotes(){
        getNotesLocalley()
        if LocalDataManager.isFirstLogin() == true || notesPublisher == []{ readNotes() }
        localDataManagerWithWriteToFirebaseToUpdateIndexs()
        reloadCollectionView.send(true)
    }
    
    
    // Save Data in defaults
    func getNotesLocalley(){
        guard let notes = LocalDataManager.getNotesLocaly() else { return }
        notesPublisher = notes
    }
    
    
    func writeNotesToFirebase(){
        guard let notesDataLocaly = LocalDataManager.getNotesLocaly() else { return }
        firebase.write(data: notesDataLocaly)
    }
    
    func updateNotesFirebase(note: Note , index: Int){
        firebase.update(data: noteAsDictionary(note: note),childIndex: index)
    }
    
    func delete(index: Int){
        firebase.delete(index: index)
    }
    
    func deleteAll(){
        firebase.deleteAll()
    }
    
    // read data from firebase
    // Note this call in just oneA
    func readNotes(){
        Task{
            guard let notes = await firebase.read() else{ return }
            self.notesPublisher = notes
            localDataManagerWithWriteToFirebaseToUpdateIndexs()
            self.reloadCollectionView.send(true)
        }
    }
    
}
