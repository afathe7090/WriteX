//
//  Document+Protocols.swift
//  WriteX
//
//  Created by Ahmed Fathy on 11/03/2022.
//

import UIKit
import Combine

protocol ConfirmAddNote: AnyObject {
    func confirmAddNote(note: Note)
}

protocol MenuButtonProtocol: AnyObject {
    func presentAlert(_ index: Int)
}

// Set Editting Note or Add
extension DocumentVC: ConfirmAddNote {
    func confirmAddNote(note: Note) {
        viewModel.setEdittingOrAddingNote(note)
    }
}

protocol HiddenViewProtocol: AnyObject {
    func configureHiddenType()
}


// setUp Menu Button 
extension DocumentVC: MenuButtonProtocol{
    
     //MARK: - Handel Settings Of cell
    func presentAlert(_ index: Int){
        
        let optionMenue = UIAlertController(title: "FB", message: "Please Select an Option ", preferredStyle: .actionSheet)
        
        let hideAction = UIAlertAction(title: viewModel.isHiddenNotes == true ? "Show":"Hide", style: .default) { alert in

            self.viewModel.hidenNoteSelectedBy(index)
            self.collectionView.reloadData()
        }
        
        let reomveNote = UIAlertAction(title: "Remove", style: .destructive) { alert in
          
            self.viewModel.removeNoteSelectedBy(index)
            self.collectionView.reloadData()
        }
        
        
        let caneclAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenue.addAction(hideAction)
        optionMenue.addAction(reomveNote)
        optionMenue.addAction(caneclAction)
        
        
        present(optionMenue, animated: true, completion: nil)
    }
    
}

extension DocumentVC: HiddenViewProtocol {
    func configureHiddenType() {
        viewModel.isHiddenNotes = !viewModel.isHiddenNotes
        
        print(viewModel.isHiddenNotes)
        print(viewModel.notesPublisher)
    }
    
    
}
