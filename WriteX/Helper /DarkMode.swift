//
//  DarkMode.swift
//  WriteX
//
//  Created by Ahmed Fathy on 14/03/2022.
//

import UIKit

enum Theme: String {
    case light, dark, system

    // Utility var to pass directly to window.overrideUserInterfaceStyle
    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
    
    init() {
        self = .system
    }
}
