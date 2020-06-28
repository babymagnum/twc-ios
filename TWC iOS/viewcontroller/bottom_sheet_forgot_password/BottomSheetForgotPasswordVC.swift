//
//  BottomSheetForgotPasswordVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 28/06/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit
import RxSwift

class BottomSheetForgotPasswordVC: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fieldEmail: CustomTextField!
    @IBOutlet weak var buttonSend: CustomButton!
    
    @Inject private var loginVM: LoginVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        observeData()
    }
    
    private func observeData() {
        loginVM.successForgotPassword.subscribe(onNext: { value in
            if value {
                self.dismiss(animated: true, completion: nil)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        buttonSend.isEnabled = false
        fieldEmail.delegate = self
        fieldEmail.addTarget(self, action: #selector(fieldEmailDidChange), for: .editingChanged)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fieldEmail {
            fieldEmail.resignFirstResponder()
        }
        
        return false
    }
    
    @IBAction func sendClick(_ sender: Any) {
        loginVM.didForgotPassword.accept(true)
        loginVM.showLoading(originVC: self)
    }
    
    @objc func fieldEmailDidChange(textField: UITextField) {
        buttonSend.isEnabled = fieldEmail.trim() != ""
        buttonSend.backgroundColor = fieldEmail.trim() != "" ? UIColor.mediumGreen : UIColor.veryLightPink
    }
}
