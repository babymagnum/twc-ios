//
//  SplashController.swift
//  Angkasa Pura Solusi
//
//  Created by Arief Zainuri on 27/07/19.
//  Copyright © 2019 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import DIKit

class SplashController: BaseViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        preference.saveBool(value: true, key: constant.IS_RELEASE)
        
        changeScreen()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    private func changeScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let isLogin = self.preference.getBool(key: self.constant.IS_LOGIN)
            let isOnboarding = self.preference.getBool(key: self.constant.IS_ONBOARDING)
            
            if !isOnboarding {
                self.navigationController?.pushViewController(OnboardingVC(), animated: true)
            } else if !isLogin {
                self.navigationController?.pushViewController(LoginVC(), animated: true)
            } else {
                self.navigationController?.pushViewController(HomeVC(), animated: true)
            }
        }
    }
    
}
