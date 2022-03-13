//
//  AddNotesVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 06/03/2022.
//

import Foundation
import Combine


class AddNotesViewModel {
    
    @Published var stateOfView: StateOfAddNote = .add
    @Published var note: Note!
    @Published var isHiddenNote = false
    
    let titleNote = CurrentValueSubject<String,Never>("")
    let discriptionNote = CurrentValueSubject<String,Never>("")
    
    
     //MARK: - Init
    init(){}
    
     //MARK: - Helper Functions

    func changeStateOfButton()-> AnyPublisher<Bool,Never> {
        return Publishers.CombineLatest(titleNote, discriptionNote).map{ (title, discribtion) in
            return title == "" && discribtion == ""
        }.eraseToAnyPublisher()
    }
    
}
