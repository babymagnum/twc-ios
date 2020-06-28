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
    
    func loading(vc: UIViewController?) {
        if didForgotPassword.value {
            forgotPassword {
                self.didForgotPassword.accept(false)
                vc?.dismiss(animated: true, completion: nil)
                self.successForgotPassword.accept(true)
            }
        } else if didLogin.value {
            login {
                self.didLogin.accept(false)
                vc?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func showLoading(originVC: UIViewController?) {
        print("show loading vm")
        let vc = DialogLoadingVC()
        vc.delegate = self
        showCustomDialog(destinationVC: vc, originVC: originVC)
    }
    
    func forgotPassword(completion: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion()
        }
    }
    
    func login(completion: @escaping() -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion()
        }
    }
}
