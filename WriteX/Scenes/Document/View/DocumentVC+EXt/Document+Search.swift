//
//  Document+Search.swift
//  WriteX
//
//  Created by Ahmed Fathy on 11/03/2022.
//

import UIKit

//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Search Extension
//----------------------------------------------------------------------------------------------------------------
extension DocumentVC: UISearchResultsUpdating , UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterNotesBy()
        collectionView.reloadData()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.searchBarActive = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.searchBarActive = false
    }
    
    
}
