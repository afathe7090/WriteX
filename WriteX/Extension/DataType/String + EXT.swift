//
//  String + EXT.swift
//  WriteX
//
//  Created by Ahmed Fathy on 18/03/2022.
//

import Foundation

extension String {
    
     func withNewSpaceIfFound()-> String {
         self.components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
}
