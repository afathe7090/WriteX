//
//  Document+CollectionView.swift
//  WriteX
//
//  Created by Ahmed Fathy on 11/03/2022.
//

import UIKit


//MARK: - Collection VIew Protocols
extension DocumentVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    //MARK: - Number of rows
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
    //MARK: - Cell for Row
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == 0) && viewModel.searchBarActive == false {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.cellID,
                                                          for: indexPath) as! AddCell
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotesCell.cellID,
                                                          for: indexPath) as! NotesCell
            cell.delegate = self
            viewModel.setUpNotesCell(cell, index: indexPath.row)
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
        
        if indexPath.row == 0 , viewModel.searchBarActive == false {
            viewModel.isEditting = false
        }else{
            delegate?.configureNote(viewModel.presentedNote(index: indexPath.row))
            delegate.isHiddenNotes(viewModel.isHiddenNotes)
        }
        present(navigationVC, animated: true)
    }
    
}

