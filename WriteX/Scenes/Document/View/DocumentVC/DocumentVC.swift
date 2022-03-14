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
    
    
    private let refreshControl = UIRefreshControl()
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
       
        viewModel.setDataNotes()
        
        
        configureSearchController()
        configureCollectionViewCells()
        
        configureRefreshControl()
        bindToReloadCollectionView()
        bindToSearchBarText()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.isActive = false
        collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.reloadData()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    private func configureSearchController(){
        navigationItem.searchController                       = searchController
        searchController.searchBar.placeholder                = "Search Note"
        searchController.searchBar.autocapitalizationType     = .none
        searchController.searchResultsUpdater                 = self
        searchController.delegate                             = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func configureCollectionViewCells(){
        collectionView.dataSource = self
        collectionView.delegate   = self
        collectionView.setCollectionViewLayout(.defaultLayout(), animated: true)
        collectionView.register(UINib(nibName: AddCell.cellID, bundle: nil), forCellWithReuseIdentifier: AddCell.cellID)
        collectionView.register(UINib(nibName: NotesCell.cellID, bundle: nil), forCellWithReuseIdentifier: NotesCell.cellID)
    }
    
    func bindToSearchBarText(){
        searchController.searchBar.textDidChangePublisher.sink { str in
            self.viewModel.searchBarPublisher.send(str)
        }.store(in: &cancelable)
    }
    
    
    
    func bindToReloadCollectionView(){
        viewModel.reloadCollectionView.sink { state in
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }.store(in: &self.cancelable)
    }
    
    func configureRefreshControl(){
        collectionView.refreshControl = refreshControl
        refreshControl.controlEventPublisher(for: .valueChanged).sink { _ in
            self.viewModel.setDataNotes()
            self.refreshControl.endRefreshing()
        }.store(in: &cancelable)
    }
    
}


