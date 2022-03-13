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
            }
        }.store(in: &cancelabel)
    }
    
    
}
