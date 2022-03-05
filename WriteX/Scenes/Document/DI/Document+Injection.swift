//
//  Document+Injection.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Swinject


extension Container {
    public func documentDiContainer(){
        register(DocumentViewModel.self) { resolver in
            let viewModel = DocumentViewModel()
            viewModel.firebase = resolver.resolve(FirebaseWorker.self)
            return viewModel
        }
        
        register(DocumentVC.self) { resolver in
            let  documentVC = DocumentVC()
            documentVC.viewModel = resolver.resolve(DocumentViewModel.self)
            return documentVC
        }
    }
}
