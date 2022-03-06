//
//  AddNotesDI.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import Foundation
import Swinject

extension Container {
    
    public func addNotesDIContainer(){
        
        register(AddNotesViewModel.self) { resolver in
            let viewModel = AddNotesViewModel()
            return viewModel
        }
        
        register(AddNotesVC.self) { resolver in
            let  addNotes = AddNotesVC()
            addNotes.viewModel = resolver.resolve(AddNotesViewModel.self)
            return addNotes
        }
        
    }
    
}
