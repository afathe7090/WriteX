//
//  DarkMode.swift
//  WriteX
//
//  Created by Ahmed Fathy on 14/03/2022.
//

import UIKit

enum Theme: String, Equatable {
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
    
    static func updateStaeOfThemes(){
        LocalDataManager.configureSystemStyle(theme: LocalDataManager.themeOfInterface())
        AppDelegate().overrideApplicationThemeStyle()
    }
}




extension AppDelegate {
    func overrideApplicationThemeStyle() {
        if #available(iOS 13.0, *) {
            // Retrieve your NSUserDefaults value here
            let stateInterface = LocalDataManager.themeOfInterface()
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveLinear, animations: {
                UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = stateInterface.uiInterfaceStyle
                }, completion: .none)
        } else {
            // Fallback on earlier versions
        }
    }
}
