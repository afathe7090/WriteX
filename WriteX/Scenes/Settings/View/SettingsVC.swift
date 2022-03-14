//
//  SettingsVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 04/03/2022.
//

import UIKit
import Combine
import CombineCocoa

class SettingsVC: UIViewController {

    weak var delegate: HiddenViewProtocol!
    var viewModel: SettingsViewModel!
    var cancelabel = Set<AnyCancellable>()
    
     //MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var hidenNotesCell: UITableViewCell!
    @IBOutlet var emailTableViewCell: UITableViewCell!
    @IBOutlet var logOutCell: UITableViewCell!
    @IBOutlet var darkModelCell: UITableViewCell!
    
    @IBOutlet weak var emailOfUserLabel: UILabel!
    @IBOutlet weak var switchDarkMode: UISwitch!
    
    
    
    
     //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Setting"
        viewModel.configureLoginUser()
        configureTableViewCellBinding()
        bindToEmailConfiguretion()
        bindToSelectItemsOfTableVIew()
        handelSwitchState()
        handelActionOfSwith()
    }
    
    func configureTableViewCellBinding(){
        viewModel.$constantCellData.sink(receiveValue: tableView.items({( tableView, indexPath, element)-> UITableViewCell in
            if (indexPath.section == 0) && (indexPath.row == 0) { return self.emailTableViewCell}
            if (indexPath.section == 0) && (indexPath.row == 1) { return self.hidenNotesCell}
            if (indexPath.section == 0) && (indexPath.row == 2) { return self.darkModelCell}
            if (indexPath.section == 0) && (indexPath.row == 3) { return self.logOutCell}
            return UITableViewCell()
        })).store(in: &cancelabel)
    }
    
    
    func bindToEmailConfiguretion(){
        viewModel.$userAuth.sink { user in
            self.emailOfUserLabel.text = user?.email
        }.store(in: &cancelabel)
    }

    func bindToSelectItemsOfTableVIew(){
        tableView.didSelectRowPublisher.sink { index in
            if index.row == 1 {
                //Go TO Hidden Document
                guard let documentVC = container.resolve(DocumentVC.self) else { return }
                self.delegate = documentVC
                self.delegate.configureHiddenType()
                self.navigationController?.pushViewController(documentVC, animated: true)
//                let navigationDocument = UINavigationController(rootViewController: documentVC)
//                self.present(navigationDocument, animated: true, completion: nil)
            }else if index.row == 3{
                self.handelAllDataToBeNUll()
                guard let rootVC = container.resolve(LoginVC.self) else { return }
                rootVC.modalPresentationStyle = .fullScreen
                rootVC.modalTransitionStyle = .flipHorizontal
                self.present(rootVC, animated: true, completion: nil)
            }
        }.store(in: &cancelabel)
    }
    
    func handelSwitchState(){
        let stateOfMode = LocalDataManager.themeOfInterface()
        DispatchQueue.main.async {
            self.switchDarkMode.isOn = stateOfMode.uiInterfaceStyle == .dark
        }
    }
    
    func handelActionOfSwith(){

        switchDarkMode.addTarget(self, action: #selector(handelSwitshOfAction), for: .allEvents)
    }
    
    
    @objc
    func handelSwitshOfAction(){
        
        LocalDataManager.configureSystemStyle(theme: switchDarkMode.isOn == true ? .dark:.light)
        AppDelegate().overrideApplicationThemeStyle()
    }
    
    func handelAllDataToBeNUll(){
        LocalDataManager.saveLoginUser(user: nil)
        LocalDataManager.saveNotesLocaly(nil)
        LocalDataManager.firstLoginApp(true)
    }
    
    
    
}
