//
//  BaseTabBar.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit

class BaseTabBar: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {self.viewControllers = [self.createDocumentVC() , self.createSettingVC()] }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func createDocumentVC()-> UINavigationController {
        guard let documentVC = container.resolve(DocumentVC.self) else { fatalError() }
        let documentNavigation = UINavigationController(rootViewController: documentVC)
        documentNavigation.title = "Document"
        documentNavigation.navigationController?.navigationBar.isHidden = false
        documentNavigation.navigationItem.largeTitleDisplayMode = .always
        documentNavigation.navigationBar.prefersLargeTitles = true
        documentNavigation.tabBarItem.image = UIImage(systemName: "folder")
        return documentNavigation
    }
    
    func createSettingVC()-> UINavigationController {
        guard let settingsVC = container.resolve(SettingsVC.self) else { fatalError() }
        let settingsNavigation = UINavigationController(rootViewController: settingsVC)
        settingsNavigation.title = "Setting"
        settingsNavigation.navigationController?.navigationBar.isHidden = false
        settingsNavigation.navigationItem.largeTitleDisplayMode = .always
        settingsNavigation.navigationBar.prefersLargeTitles = true
        settingsNavigation.tabBarItem.image = UIImage(systemName: "gear")
        return settingsNavigation
    }
    

}
