//
//  DocumentVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit

class DocumentVC: UIViewController {
    
    
    var viewModel: DocumentViewModel!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Document"
        
        
    }
    
    private func configureSearchController(){
        navigationItem.searchController             = searchController
        searchController.searchBar.placeholder      = "Search Note"
        searchController.searchResultsUpdater       = self
    }
    
}


extension DocumentVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
