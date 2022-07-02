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
        // setup data from locally and get state of Interface
        viewModel.bindToChangeModeOfInterface()
        // set table view data source
        configureTableViewCellBinding()
        bindToSelectItemsOfTableVIew()
        setUpTask()
        switchOfBindingWithViewModel()
    }
    
    
     //MARK: -  Helper Function
    
    func setUpTask(){
        Task{
            await bindToEmailConfiguretion()
        }
    }
    
    
     //MARK: - Setup User data that saved from Login
    func bindToEmailConfiguretion() async {
        DispatchQueue.main.async {
            self.viewModel.$userAuth.sink { user in
                self.emailOfUserLabel.text = user?.email
            }.store(in: &self.cancelabel)
        }
    }
    
    
     //MARK: - cell of row at TableView DataSource
    func configureTableViewCellBinding(){
        viewModel.$constantCellData.sink(receiveValue: tableView.items({( tableView, indexPath, element)-> UITableViewCell in
            if (indexPath.section == 0) && (indexPath.row == 0) { return self.emailTableViewCell}
            if (indexPath.section == 0) && (indexPath.row == 1) { return self.hidenNotesCell}
            if (indexPath.section == 0) && (indexPath.row == 2) { return self.darkModelCell}
            if (indexPath.section == 0) && (indexPath.row == 3) { return self.logOutCell}
            return UITableViewCell()
        })).store(in: &cancelabel)
    }
    
    

    
     //MARK: -  Handel Action Of tableVIew
    func bindToSelectItemsOfTableVIew(){
        tableView.didSelectRowPublisher.sink { index in
            if index.row == 1 {
                //Go TO Hidden Document
                guard let documentVC = container.resolve(DocumentVC.self) else { return }
                self.delegate = documentVC
                self.delegate.configureHiddenType()
                self.navigationController?.pushViewController(documentVC, animated: true)
               
            }else if index.row == 3{
                self.viewModel.handelAllDataToBeNUll()
                guard let rootVC = container.resolve(LoginVC.self) else { return }
                rootVC.modalPresentationStyle = .fullScreen
                rootVC.modalTransitionStyle = .flipHorizontal
                self.present(rootVC, animated: true, completion: nil)
            }
        }.store(in: &cancelabel)
    }
    
    
    
    
    
     //MARK: -  Handel Switch
    func switchOfBindingWithViewModel(){
        // get status of Dark mode from Local Database
        viewModel.configureSwithISOnStateFromLocallyDatabase()
        switchDarkMode.addTarget(self , action: #selector(handelActionFOrSwitchController),for: .allEvents)
        switchDarkMode.isOn = viewModel.isOnPublisher.value
        
    }
    
    //MARK: - handel Action of Switch
    @objc func handelActionFOrSwitchController(){
        self.viewModel.isOnPublisher.send(self.switchDarkMode.isOn)
    }
    
    
}
