//
//  NSAttribute.swift
//  WriteX
//
//  Created by Ahmed Fathy on 03/03/2022.
//

import UIKit


extension UIButton {
    
    func addMutableString(txt1:String
                          ,txt2: String){
        let multiAttribute = NSMutableAttributedString(string: txt1,
                                                       attributes: [.font: UIFont.systemFont(ofSize: 16)
                                                                    ,.foregroundColor: UIColor.label])
        multiAttribute.append(NSAttributedString(string: txt2
                                                 , attributes: [.font: UIFont.systemFont(ofSize: 16)
                                                                , .foregroundColor: UIColor.blue.withAlphaComponent(0.7)]))
        self.setAttributedTitle(multiAttribute, for: .normal)
    }
    
}
