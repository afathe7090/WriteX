//
//  RegisterVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import UIKit
import Combine
import CombineCocoa

class RegisterVC: UIViewController {

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var backButtonPressed: UIButton! { didSet { backButtonPressed.setCornerRadius(20) }}
    @IBOutlet weak var confirmPasswordTextField: UITextField! { didSet { confirmPasswordTextField.setCornerRadius(4) }}
    @IBOutlet weak var passwordTextField: UITextField!  { didSet { passwordTextField.setCornerRadius(4) }}
    @IBOutlet weak var registerButtonPressed: UIButton!  { didSet { registerButtonPressed.setCornerRadius(7) }}
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.setCornerRadius(4) }}
    @IBOutlet weak var backToLogin: UIButton!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Var
    //----------------------------------------------------------------------------------------------------------------
    var viewModel: RegisterViewModel!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackToLoginAttr()
    }

    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Configure
    //----------------------------------------------------------------------------------------------------------------
    private func configureBackToLoginAttr(){
        backToLogin.addMutableString(txt1: "I have an account ", txt2: " Login")
    }
    
    
    
}
