//
//  UIColor+EXT.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import UIKit

extension UIColor {
    
    static func rgbColor(_ red: CGFloat ,_ grean: CGFloat ,_ blue: CGFloat)-> UIColor {
        return UIColor(red: red/255, green: grean/255, blue: blue/255, alpha: 1.0)
    }
    
    static let backgoundColor = UIColor.rgbColor(25, 25, 25)
    static let mainBlueTint = UIColor.rgbColor(17, 154, 237)
    
}
