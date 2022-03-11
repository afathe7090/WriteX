//
//  Array+ET.swift
//  WriteX
//
//  Created by Ahmed Fathy on 10/03/2022.
//

import UIKit

extension Array where Element: Equatable  {
    mutating func remove(element: Iterator.Element) {
        self = self.filter{$0 != element }
    }
}
