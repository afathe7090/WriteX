//
//  Document+Protocols.swift
//  WriteX
//
//  Created by Ahmed Fathy on 11/03/2022.
//

import UIKit

protocol ConfirmAddNote: AnyObject {
    func confirmAddNote(note: Note)
}

protocol MenuButtonProtocol: AnyObject {
    func presentAlert()
}

// Set Editting Note or Add
extension DocumentVC: ConfirmAddNote {
    func confirmAddNote(note: Note) {
        viewModel.setEdittingOrAddingNote(note)
    }
}


// setUp Menu Button 
extension DocumentVC: MenuButtonProtocol{
    
     //MARK: - Handel Settings Of cell
    func presentAlert(){
        
        let optionMenue = UIAlertController(title: "FB", message: "Please Select an Option ", preferredStyle: .actionSheet)
        
        let hideAction = UIAlertAction(title: "Hide", style: .default) { alert in
            
        }
        
        let reomveNote = UIAlertAction(title: "Remove", style: .destructive) { alert in
        }
        
        
        let caneclAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenue.addAction(hideAction)
        optionMenue.addAction(reomveNote)
        optionMenue.addAction(caneclAction)
        present(optionMenue, animated: true, completion: nil)
    }
    
}
