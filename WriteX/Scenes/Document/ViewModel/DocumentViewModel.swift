//
//  DocumentViewModel.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import Foundation
import Combine


class DocumentViewModel {
    
    
    let notesPublisher = CurrentValueSubject<[Notes],Never>([Notes]())
    
    var firebase: FirebaseWorker!
    
    func configureDataPublisher(){
        let notes:[Notes] = [.init(title: "ljflkdsjf", description: "fkjlsjdljsdlkf", date: getCurrentData()),
                             .init(title: "ljflkdsjf", description: "fkjlsjdljsdlkf", date: getCurrentData()),
                             .init(title: "ljflkdsjf", description: "fkjlsjdljsdlkf", date: getCurrentData()),
                             .init(title: "ljflkdsjf", description: "fkjlsjdljsdlkf", date: getCurrentData()),
                             .init(title: "ljflkdsjf", description: "fkjlsjdljsdlkf", date: getCurrentData())]
        notesPublisher.send(notes)
    }
    
    init(){}
}
