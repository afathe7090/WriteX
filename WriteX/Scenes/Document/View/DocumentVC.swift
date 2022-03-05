//
//  DocumentVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Combine


class DocumentVC: UIViewController {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Data Type
    //----------------------------------------------------------------------------------------------------------------
    var viewModel: DocumentViewModel!
    private var cancelable = Set<AnyCancellable>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  UI
    //----------------------------------------------------------------------------------------------------------------
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Document"
        configureSearchController()
        configureCollectionViewCells()
        viewModel.configureDataPublisher()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    private func configureSearchController(){
        navigationItem.searchController                       = searchController
        searchController.searchBar.placeholder                = "Search Note"
        searchController.searchResultsUpdater                 = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func configureCollectionViewCells(){
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(.defaultLayout(), animated: true)
        collectionView.register(UINib(nibName: AddCell.cellID, bundle: nil), forCellWithReuseIdentifier: AddCell.cellID)
        collectionView.register(UINib(nibName: NotesCell.cellID, bundle: nil), forCellWithReuseIdentifier: NotesCell.cellID)
    }
    
    
    
    
    
}


//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Search Extension
//----------------------------------------------------------------------------------------------------------------
extension DocumentVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        collectionView.reloadData()
    }
}


extension DocumentVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive == false ? viewModel.notesPublisher.value.count + 1:viewModel.notesPublisher.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0) && searchController.isActive == false {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.cellID,
                                                          for: indexPath) as! AddCell
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.cellID,
                                                          for: indexPath) as! NotesCell
            
            let note = viewModel.notesPublisher.value[ searchController.isActive == true ?  indexPath.row:indexPath.row - 1]
            cell.setCell(note)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
