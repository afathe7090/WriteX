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
    @IBOutlet weak var loginPageButton: UIButton!
    
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Var
    //----------------------------------------------------------------------------------------------------------------
    var viewModel: RegisterViewModel!
    var cancelable = Set<AnyCancellable>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe Cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackToLoginAttr()
        
        configueActions()
        configureBinding()
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Configure
    //----------------------------------------------------------------------------------------------------------------
    private func configureBackToLoginAttr(){
        loginPageButton.addMutableString(txt1: "I have an account ", txt2: " Login")
    }
    
    
    //MARK: - Actions
    private func configueActions(){
        Task{
            await configureBackButtonAction()
            await configureLoginPage()
            await configureRegisterButtonAction()
        }
    }
    
    private func configureBackButtonAction() async {
        DispatchQueue.main.async {
            self.backButtonPressed.tapPublisher.sink { _ in
                self.navigationController?.popViewController(animated: true)
            }.store(in: &self.cancelable)
        }
    }
    
    private func configureRegisterButtonAction() async {
        DispatchQueue.main.async {
            self.registerButtonPressed.tapPublisher.receive(on: DispatchQueue.main)
                .sink { _ in
                    self.viewModel.signUp()
                }.store(in: &self.cancelable)
        }
    }
    
    private func configureLoginPage() async {
        DispatchQueue.main.async {
            self.loginPageButton.tapPublisher.sink { _ in
                self.navigationController?.popViewController(animated: true)
            }.store(in: &self.cancelable)
        }
    }
    
    
    //MARK: - Binding
    
    private func configureBinding(){
        Task{
            await configureTextFieldBinding()
            await configureEmailAnimation()
            await configurePasswordAnimation()
            await configureConfirmPasswordAnimation()
        }
    }
    
    private func configureTextFieldBinding() async {
        DispatchQueue.main.async {
            self.emailTextField.creatTextFieldBinding(with: self.viewModel.emailPublisher,
                                                      storeIn: &self.cancelable)
            self.passwordTextField.creatTextFieldBinding(with: self.viewModel.passwordPublisher,
                                                         storeIn: &self.cancelable)
            self.confirmPasswordTextField.creatTextFieldBinding(with: self.viewModel.confirmPasswordPublisher,
                                                                storeIn: &self.cancelable)
        }
    }
    
    private func configureEmailAnimation() async {
        viewModel.animationEmailPublisher.receive(on: DispatchQueue.main).sink { state in
            if state { self.emailTextField.shakeField() }
        }.store(in: &cancelable)
    }
    
    
    private func configurePasswordAnimation() async {
        viewModel.animationaPassPublisher.receive(on: DispatchQueue.main).sink { state in
            if state { self.passwordTextField.shakeField() }
        }.store(in: &cancelable)
    }
    
    private func configureConfirmPasswordAnimation() async {
        viewModel.animationConfirmPasswordPublisher.receive(on: DispatchQueue.main).sink { state in
            if state { self.confirmPasswordTextField.shakeField() }
        }.store(in: &cancelable)
    }
    
    
    
}

//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Touch end
//----------------------------------------------------------------------------------------------------------------
extension RegisterVC{
    override func touchesEnded(_ touches: Set<UITouch>
                               , with event: UIEvent?) {
        view.endEditing(true)
    }
}
