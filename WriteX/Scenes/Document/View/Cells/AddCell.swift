//
//  AddCell.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import UIKit

class AddCell: UICollectionViewCell {

    static let cellID = "AddCell"
    @IBOutlet weak var backView: UIView!{didSet { backView.layer.cornerRadius = 15}}
    
    @IBOutlet weak var addButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
