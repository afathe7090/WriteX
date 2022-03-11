//
//  DocumentVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Combine
import CombineCocoa

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
    weak var delegate: ConfirmEditNote!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Document"
        viewModel.getNotesLocalley()
        configureSearchController()
        configureCollectionViewCells()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    private func configureSearchController(){
        navigationItem.searchController                       = searchController
        searchController.searchBar.placeholder                = "Search Note"
        searchController.searchBar.autocapitalizationType     = .none
        searchController.searchResultsUpdater                 = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func configureCollectionViewCells(){
        collectionView.dataSource = self
        collectionView.delegate   = self
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
        viewModel.filterNotesBy(searchText: searchController.searchBar.text!)
        collectionView.reloadData()
    }
}

//MARK: - Collection VIew Protocols
extension DocumentVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //MARK: - Number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive == false ? viewModel.notesPublisher.map({$0.isHidden == false}).count + 1:viewModel.filterPublisher.map({$0.isHidden == false}).count
    }
    
    
    
    //MARK: - Cell for Row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0) && searchController.isActive == false {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.cellID,
                                                          for: indexPath) as! AddCell
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.cellID,
                                                          for: indexPath) as! NotesCell
            let note = searchController.isActive == true ? viewModel.filterPublisher[indexPath.row]:viewModel.notesPublisher[indexPath.row - 1]
            cell.setCell(note)
            return cell
        }
    }
    
    
    
    
    
    //MARK: - DidSelect
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let addNote = container.resolve(AddNotesVC.self) else { return }
        let navigationVC = UINavigationController(rootViewController: addNote)
        navigationVC.modalPresentationStyle = .fullScreen
        delegate = addNote
        addNote.delegate = self
        // Note Save the UUID For the Edit Cell
        if indexPath.row == 0 , searchController.isActive == false {
            // present with add Note that is active when the searchController is not active
            viewModel.isEditting = false
        }else{
            // present with Edit Note in all time active SearchController OR Not
            viewModel.isEditting = true
            let note = searchController.isActive == true ? viewModel.filterPublisher[indexPath.row]:viewModel.notesPublisher[indexPath.row - 1]
            viewModel.edittingNote = note
            delegate?.configureNote(note)
        }
        
        present(navigationVC, animated: true)
    }
    
}

// Set Editting Note or Add
extension DocumentVC: ConfirmAddNote {
    func confirmAddNote(note: Note) {
        viewModel.setEdittingOrAddingNote(note)
        collectionView.reloadData()
    }
}
