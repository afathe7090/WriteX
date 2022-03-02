//
//  LoginVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import UIKit
import Combine

class LoginVC: UIViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButtonPressed: UIButton!
    @IBOutlet weak var forgetPasswordButtn: UIButton!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayerLayout()
        configureRegisterButtonAttr()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    private func configureRegisterButtonAttr(){
        
        let multiAttribute = NSMutableAttributedString(string: "Don't have an account? ",
                                                       attributes: [.font: UIFont.systemFont(ofSize: 16) ,.foregroundColor: UIColor.label])
        multiAttribute.append(NSAttributedString(string: " Register now"
                                                 , attributes: [.font: UIFont.systemFont(ofSize: 16) , .foregroundColor: UIColor.mainBlueTint]))
        
        registerButton.setAttributedTitle(multiAttribute, for: .normal)
    }
    
    
    private func configureLayerLayout(){
        emailTextField.setCornerRadius(4)
        passwordTextField.setCornerRadius(4)
        loginButtonPressed.setCornerRadius(7)
    }
    
}
