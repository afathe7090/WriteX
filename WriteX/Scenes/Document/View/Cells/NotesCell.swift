//
//  NotesCell.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import UIKit

class NotesCell: UICollectionViewCell {

    static let cellID = "NotesCell"
    
    @IBOutlet weak var backView: UIView! { didSet { backView.layer.cornerRadius = 15}}
    @IBOutlet weak var dateOfNotes: UILabel!
    @IBOutlet weak var descriptionOfNote: UILabel!
    @IBOutlet weak var titleOfNotes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(_ note: Note){
        titleOfNotes.text      = note.title
        descriptionOfNote.text = note.description
        dateOfNotes.text       = note.date
    }
    

}
