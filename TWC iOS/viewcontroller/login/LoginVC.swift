//
//  LoginVC.swift
//  Eoviz Presence
//
//  Created by Arief Zainuri on 08/04/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import DIKit
import SVProgressHUD

class LoginVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var buttonShowHidePassword: UIButton!
    @IBOutlet weak var fieldEmail: CustomTextField!
    @IBOutlet weak var fieldPassword: CustomTextField!
    @IBOutlet weak var buttonMasuk: CustomButton!
    
    @Inject var loginVM: LoginVM
    private var disposeBag = DisposeBag()
    private var passwordHide = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupEvent()
        
        observeData()
    }
    
    private func observeData() {
        loginVM.successForgotPassword.subscribe(onNext: { value in
            if value {
                self.navigationController?.pushViewController(LupaKataSandiBerhasilVC(), animated: true)
                self.loginVM.successForgotPassword.accept(false)
            }
        }).disposed(by: disposeBag)
        
        loginVM.successLogin.subscribe(onNext: { value in
            if value {
                guard let loginVC = self.navigationController?.viewControllers.last(where: { $0.isKind(of: LoginVC.self) }) else { return }
                let index = self.navigationController?.viewControllers.lastIndex(of: loginVC) ?? 0
                self.navigationController?.pushViewController(HomeVC(), animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.viewControllers.remove(at: index)
                }
                
                self.loginVM.successLogin.accept(false)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        buttonShowHidePassword.setImage(UIImage(named: "invisible")?.tinted(with: UIColor.brownGreyTwo), for: .normal)
        buttonMasuk.isEnabled = false
    }
    
    private func setupEvent() {
        fieldEmail.delegate = self
        fieldPassword.delegate = self
        fieldEmail.addTarget(self, action: #selector(fieldEmaildDidChange), for: .editingChanged)
        fieldPassword.addTarget(self, action: #selector(fieldPasswordDidChange), for: .editingChanged)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fieldEmail {
            fieldEmail.resignFirstResponder()
            fieldPassword.becomeFirstResponder()
        } else if textField == fieldPassword {
            fieldPassword.resignFirstResponder()
        }
        
        return false
    }
}

extension LoginVC {
    private func changeButtonMasuk() {
        loginVM.email.accept(fieldEmail.trim())
        loginVM.password.accept(fieldPassword.trim())
        buttonMasuk.backgroundColor = fieldEmail.trim() != "" && fieldPassword.trim() != "" ? UIColor.tangerine : UIColor.veryLightPink
        buttonMasuk.isEnabled = fieldEmail.trim() != "" && fieldPassword.trim() != ""
    }
    
    @objc func fieldEmaildDidChange(textField: UITextField) { changeButtonMasuk() }
    
    @objc func fieldPasswordDidChange(textField: UITextField) {
        buttonShowHidePassword.setImage(UIImage(named: passwordHide ? "invisible" : "visibility")?.tinted(with: fieldPassword.trim() == "" ? UIColor.brownGreyTwo : UIColor.mediumGreen), for: .normal)
        changeButtonMasuk()
    }
    
    @IBAction func showHidePasswordClick(_ sender: Any) {
        passwordHide = !passwordHide
        fieldPassword.isSecureTextEntry = passwordHide
        buttonShowHidePassword.setImage(UIImage(named: passwordHide ? "invisible" : "visibility")?.tinted(with: fieldPassword.trim() == "" ? UIColor.brownGreyTwo : UIColor.mediumGreen), for: .normal)
    }
    
    @IBAction func daftarJadiAgenClick(_ sender: Any) {
        navigationController?.pushViewController(DaftarJadiAgenVC(), animated: true)
    }
    
    @IBAction func masukClick(_ sender: Any) {
        loginVM.didLogin.accept(true)
        loginVM.showLoading(nc: navigationController)
    }
    
    @IBAction func forgotPasswordClick(_ sender: Any) {
        let marginHorizontal = (screenWidth * 0.065) * 2
        let titleHeight = "Lupa kata sandi".getHeight(withConstrainedWidth: screenWidth - marginHorizontal, font: UIFont(name: "Nunito-Bold", size: 24 + PublicFunction.dynamicSize()))
        let descriptionHeight = "Masukan email anda yang telah teregistrasi".getHeight(withConstrainedWidth: screenWidth - marginHorizontal, font: UIFont(name: "Nunito-Regular", size: 16 + PublicFunction.dynamicSize()))
        let emailHeight = "Email...".getHeight(withConstrainedWidth: screenWidth - marginHorizontal, font: UIFont(name: "Nunito-Regular", size: 17 + PublicFunction.dynamicSize()))
        let sendHeight = screenWidth * 0.15
        let bottomSheetHeight = 10 + 4 + 32 + titleHeight + 16 + descriptionHeight + 36 + emailHeight + 11 + 1 + 28 + sendHeight + 28 + 25
//        let vc = UINavigationController.init(rootViewController: BottomSheetForgotPasswordVC())
        showBottomSheet(vc: BottomSheetForgotPasswordVC(), handleColor: UIColor.clear, height: bottomSheetHeight)
    }
}
