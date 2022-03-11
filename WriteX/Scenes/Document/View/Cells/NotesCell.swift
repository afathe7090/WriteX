//
//  NotesCell.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import UIKit
import Combine
import CombineCocoa


class NotesCell: UICollectionViewCell {

    static let cellID = "NotesCell"
    
    @IBOutlet weak var backView: UIView! { didSet { backView.layer.cornerRadius = 15}}
    @IBOutlet weak var dateOfNotes: UILabel!
    @IBOutlet weak var descriptionOfNote: UILabel!
    @IBOutlet weak var menuButtonCell: UIButton!
    @IBOutlet weak var titleOfNotes: UILabel!
    
    var cancelable = Set<AnyCancellable>()
    weak var delegate: MenuButtonProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureMenuButtonAntion()
    }
    
    func setCell(_ note: Note){
        titleOfNotes.text      = note.title
        descriptionOfNote.text = note.description
        dateOfNotes.text       = note.date
    }
    
    func configureMenuButtonAntion(){
        menuButtonCell.tapPublisher.sink { _ in
            self.delegate?.presentAlert(self.menuButtonCell.tag)
        }.store(in: &cancelable)
    }

}
