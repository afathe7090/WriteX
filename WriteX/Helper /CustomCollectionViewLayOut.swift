//
//  CustomCollectionViewLayOut.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/03/2022.
//

import Foundation
import UIKit

let widthScreen = UIScreen.main.bounds.width
let heightScreen = UIScreen.main.bounds.height

extension UICollectionViewLayout {
    
    
    static func defaultLayout() ->UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(widthScreen/2 - 30), heightDimension: .fractionalHeight(0.9))
        let items = NSCollectionLayoutItem(layoutSize: itemSize)
        items.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.23))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: items,count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
}

