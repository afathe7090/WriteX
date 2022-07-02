//
//  AddView+Delegation.swift
//  WriteX
//
//  Created by Ahmed Fathy on 15/03/2022.
//

import UIKit

extension AddNotesVC: ConfirmEditNote {

    func configureNote(_ note: Note, isHidden: Bool) {
        viewModel.stateOfView = .edit
        viewModel.note = note
        self.viewModel.isHiddenNote = isHidden
    }
}

//MARK: - Confirm TextView
extension AddNotesVC: UITextViewDelegate {
    
    
    func configureTextView(){
        discriptionTextView.delegate        = self
        discriptionTextView.isScrollEnabled = false
        textViewDidChange(discriptionTextView)
        textViewDidBeginEditing(discriptionTextView)
        textViewDidEndEditing(discriptionTextView)
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        let size                     = CGSize(width: view.frame.width - 20, height: .infinity)
        let estimatedSize            = discriptionTextView.sizeThatFits(size)
        heightOfTextView.constant    = estimatedSize.height
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = (textView.text == "Enter Discription" && self.title == "Add Note") ?  "":"\(String(describing: self.viewModel.note?.discription))"
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Discription"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            textView.resignFirstResponder()
        }
        
        return true
    }
}
