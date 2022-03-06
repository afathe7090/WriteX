//
//  DocumentVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Combine

protocol GetNotesProtocol: AnyObject{
    func retutnNotesSaved(_ note: Note, editedIndex: Int)
}


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
        viewModel.handelDataBackLocally()
        viewModel.handelDataLocaly()
        configureSearchController()
        configureUpdateCollectionView()
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
    
    func configureUpdateCollectionView(){
        viewModel.notesPublisher.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &cancelable)
    }
    
    
}


//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Search Extension
//----------------------------------------------------------------------------------------------------------------
extension DocumentVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.notesPublisher
            .map { $0.filter { $0.title.lowercased().contains(searchController.searchBar.text!.lowercased()) }
            }.sink { notes in
                self.viewModel.filterPublisher.value = notes
            }.store(in: &cancelable)
        
        collectionView.reloadData()
    }
}

//MARK: - Collection VIew Protocols
extension DocumentVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //MARK: - Number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive == false ? viewModel.notesPublisher.value.count + 1:viewModel.filterPublisher.value.count
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
            let note = searchController.isActive == true ? viewModel.filterPublisher.value[indexPath.row]:viewModel.notesPublisher.value[indexPath.row - 1]
            cell.setCell(note)
            return cell
        }
    }
    
    
    
    //MARK: - DidSelect
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let addNoteVC = container.resolve(AddNotesVC.self) else { return }
        let navigationVC = UINavigationController(rootViewController: addNoteVC)
        navigationVC.modalPresentationStyle = .fullScreen
        weak var delegate: AddNoteProtocol?
        
        addNoteVC.delegate = self
        delegate = addNoteVC
        
        // Note that selected
        let note = searchController.isActive == true ? viewModel.filterPublisher.value[indexPath.row]:viewModel.notesPublisher.value[indexPath.row - 1]
        
        // index note that will editing
        let indexNote = searchController.isActive == true ? indexPath.row:indexPath.row - 1
        delegate?.confirmNoteView(note ,index: indexNote)
        present(navigationVC, animated: true)
    }
}

extension DocumentVC: GetNotesProtocol {
    func retutnNotesSaved(_ note: Note, editedIndex: Int) {
        viewModel.notesPublisher.value.remove(at: editedIndex)
        viewModel.notesPublisher.value.insert(note, at: editedIndex)
    }
    
}
