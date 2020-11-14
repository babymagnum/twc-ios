//
//  LoginVM.swift
//  Eoviz Presence
//
//  Created by Arief Zainuri on 13/04/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import DIKit
import RxRelay

class LoginVM: BaseViewModel, DialogLoadingProtocol {
    
    var didForgotPassword = BehaviorRelay(value: false)
    var didLogin = BehaviorRelay(value: false)
    var successForgotPassword = BehaviorRelay(value: false)
    var successLogin = BehaviorRelay(value: false)
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    
    func loading(vc: UIViewController?, nc: UINavigationController?) {
        if didForgotPassword.value {
            forgotPassword {
                self.didForgotPassword.accept(false)
                vc?.dismiss(animated: true, completion: nil)
                self.successForgotPassword.accept(true)
            }
        } else if didLogin.value {
            login(nc: nc, email: email.value, password: password.value) { (error, authModel) in
                
                self.didLogin.accept(false)
                vc?.dismiss(animated: true, completion: {
                    if let _error = error {
                        self.showAlertDialog(image: nil, message: _error, navigationController: nc)
                        return
                    }
                    
                    guard let _authModel = authModel else { return }
                    
                    if _authModel.success {
                        self.preference.saveBool(value: true, key: self.constant.IS_LOGIN)
                        self.preference.saveString(value: _authModel.data?.token ?? "", key: self.constant.TOKEN)
                        self.preference.saveString(value: _authModel.data?.email ?? "", key: self.constant.EMAIL)
                        self.preference.saveString(value: "\(_authModel.data?.agent_id ?? 0)", key: self.constant.AGENT_ID)
                        self.successLogin.accept(true)
                    } else {
                        self.showAlertDialog(image: nil, message: _authModel.message, navigationController: nc)
                    }
                })
            }
        }
    }
    
    func showLoading(nc: UINavigationController?) {
        let vc = DialogLoadingVC()
        vc.delegate = self
        vc.nc = nc
        showCustomDialog(destinationVC: vc, nc: nc)
    }
    
    func forgotPassword(completion: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion()
        }
    }
    
    func login(nc: UINavigationController?, email: String, password: String, completion: @escaping(_ error: String?, _ authModel: AuthModel?) -> Void) {
        networking.login(request: AuthRequest(email: email, password: password)) { (error, authModel, _) in
            completion(error, authModel)
        }
    }
}
