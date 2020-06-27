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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        observeData()
        
        setupEvent()
    }
    
    private func setupView() {
        buttonShowHidePassword.setImage(UIImage(named: "invisible")?.tinted(with: UIColor.brownGreyTwo), for: .normal)
        buttonMasuk.isEnabled = false
    }
    
    private func observeData() {
        loginVM.loading.subscribe(onNext: { value in
            if value {
                SVProgressHUD.show(withStatus: "please_wait".localize())
            } else {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: disposeBag)
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
        print("daftar jadi agen")
    }
    @IBAction func masukClick(_ sender: Any) {
        print("masuk")
    }
    @IBAction func forgotPasswordClick(_ sender: Any) {
        print("forgot password")
    }
}
