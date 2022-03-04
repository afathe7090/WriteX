//
//  LoginVC.swift
//  WriteX
//
//  Created by Ahmed Fathy on 02/03/2022.
//

import UIKit
import Combine
import CombineCocoa

class LoginVC: UIViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Outlet
    //----------------------------------------------------------------------------------------------------------------
    @IBOutlet weak var emailTextField: UITextField! { didSet { emailTextField.setCornerRadius(4) }}
    @IBOutlet weak var passwordTextField: UITextField! { didSet { passwordTextField.setCornerRadius(4) }}
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButtonPressed: UIButton! { didSet { loginButtonPressed.setCornerRadius(7) }}
    @IBOutlet weak var forgetPasswordButtn: UIButton!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Var
    //----------------------------------------------------------------------------------------------------------------
    
    var viewModel: LoginViewModel!
    private var cancelable = Set<AnyCancellable>()
    private let queue = DispatchQueue(label: "main")
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Lyfe cycle
    //----------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBinding()
        configureActions()
        configureRegisterButtonAttr()
        
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Helper Functions
    //----------------------------------------------------------------------------------------------------------------
    
    private func configureRegisterButtonAttr(){
        registerButton.addMutableString(txt1: "Don't have an account? "
                                        ,txt2: " Register now")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Actions
    //----------------------------------------------------------------------------------------------------------------
    private func configureActions(){
        Task {
            await setLoginButtonAction()
            await setRegisterButtonAction()
            await setForgetButtonAction()
        }
    }
    
    
    private func setLoginButtonAction() async {
        DispatchQueue.main.async {
            self.loginButtonPressed.tapPublisher
                .receive(on: DispatchQueue.main)
                .sink {[weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.signIn()
                }.store(in: &self.cancelable)
        }
    }
    
    private func setForgetButtonAction() async {
        DispatchQueue.main.async {
            self.forgetPasswordButtn.tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    guard let forgetVC = container.resolve(ForgetVC.self) else { return }
                    self.navigationController?.pushViewController(forgetVC, animated: true)
                }.store(in: &self.cancelable)
        }
    }
    
    
    private func setRegisterButtonAction() async {
        DispatchQueue.main.async {
            self.registerButton.tapPublisher
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    guard let regiserVC = container.resolve(RegisterVC.self) else { return }
                    self.navigationController?.pushViewController(regiserVC, animated: true)
                }.store(in: &self.cancelable)
        }
    }
    
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Binding
    //----------------------------------------------------------------------------------------------------------------
    
    private func configureBinding(){
        setTextFieldBinding()
        configurePresentationBinding()
        configureAnimationForEmailTextField()
        configureAnimationForPasswordTextField()
    }
    
    private func setTextFieldBinding(){
        emailTextField.creatTextFieldBinding(with: viewModel.emailPublisher
                                             , storeIn: &cancelable)
        passwordTextField.creatTextFieldBinding(with: viewModel.passwordPublisher
                                                , storeIn: &cancelable)
    }
    
    private func configureAnimationForEmailTextField(){
        viewModel.animationEmailPublisher.sink {[ weak self ] state in
            guard let self = self else { return}
            if state { self.emailTextField.shakeField()}
        }.store(in: &cancelable)
    }
    
    private func configureAnimationForPasswordTextField(){
        viewModel.animationaPassPublisher.sink {[ weak self ] state in
            guard let self = self else { return}
            if state { self.passwordTextField.shakeField()}
        }.store(in: &cancelable)
    }
    
    private func configurePresentationBinding(){
        viewModel.presentPublisher
            .receive(on: DispatchQueue.main)
            .sink { presentModel in
                switch presentModel{
                case .home:
                    print("Home")
                }
            }.store(in: &cancelable)
    }
}

//----------------------------------------------------------------------------------------------------------------
//=======>MARK: -  Touch end
//----------------------------------------------------------------------------------------------------------------
extension LoginVC{
    override func touchesEnded(_ touches: Set<UITouch>
                               , with event: UIEvent?) {
        view.endEditing(true)
    }
}
