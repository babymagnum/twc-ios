//
//  DataAgenVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 18/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MaterialComponents.MaterialTextFields
import DIKit

class DataAgenVC: BaseViewController, IndicatorInfoProvider {

    @IBOutlet weak var buttonSelanjutnya: CustomButton!
    @IBOutlet weak var viewFieldNamaAgen: UIView!
    @IBOutlet weak var viewFieldEmail: UIView!
    @IBOutlet weak var viewFieldAlamat: UIView!
    @IBOutlet weak var viewFieldNomorTelepon: UIView!
    @IBOutlet weak var viewFieldNPWP: UIView!
    
    var controllerNamaAgen: MDCTextInputControllerFilled!
    var controllerEmail: MDCTextInputControllerFilled!
    var controllerAlamatAgen: MDCTextInputControllerFilled!
    var controllerNomorTelepon: MDCTextInputControllerFilled!
    var controllerNPWP: MDCTextInputControllerFilled!
    var fieldNamaAgen: MDCTextField!
    var fieldEmail: MDCTextField!
    var fieldAlamatAgen: MDCTextField!
    var fieldNomorTelepon: MDCTextField!
    var fieldNPWP: MDCTextField!
    
    @Inject private var daftarJadiAgenVM: DaftarJadiAgenVM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupEvent()
    }
    
    private func setupEvent() {
        fieldNamaAgen.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldAlamatAgen.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNomorTelepon.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNPWP.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupView() {
        buttonSelanjutnya.backgroundColor = UIColor.veryLightPink
        buttonSelanjutnya.isEnabled = false
        
        fieldNamaAgen = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldEmail = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldEmail.keyboardType = .emailAddress
        fieldAlamatAgen = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNomorTelepon = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNomorTelepon.keyboardType = .phonePad
        fieldNPWP = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNPWP.keyboardType = .numberPad
        
        controllerNamaAgen = MDCTextInputControllerFilled(textInput: fieldNamaAgen)
        controllerEmail = MDCTextInputControllerFilled(textInput: fieldEmail)
        controllerAlamatAgen = MDCTextInputControllerFilled(textInput: fieldAlamatAgen)
        controllerNomorTelepon = MDCTextInputControllerFilled(textInput: fieldNomorTelepon)
        controllerNPWP = MDCTextInputControllerFilled(textInput: fieldNPWP)
        
        addMaterialField(field: fieldNamaAgen, controller: controllerNamaAgen, placeholder: "Nama agen", viewParent: viewFieldNamaAgen)
        addMaterialField(field: fieldEmail, controller: controllerEmail, placeholder: "Email", viewParent: viewFieldEmail)
        addMaterialField(field: fieldAlamatAgen, controller: controllerAlamatAgen, placeholder: "Alamat agen", viewParent: viewFieldAlamat)
        addMaterialField(field: fieldNomorTelepon, controller: controllerNomorTelepon, placeholder: "Nomor telepon (+62)", viewParent: viewFieldNomorTelepon)
        addMaterialField(field: fieldNPWP, controller: controllerNPWP, placeholder: "NPWP", viewParent: viewFieldNPWP)
    }
    
    private func addMaterialField(field: MDCTextField, controller: MDCTextInputControllerFilled, placeholder: String, viewParent: UIView) {
        controller.placeholderText = placeholder
        controller.floatingPlaceholderActiveColor = UIColor.mediumGreen
        field.font = UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize())
        controller.borderFillColor = UIColor.clear
        controller.underlineHeightActive = 0
        controller.underlineHeightNormal = 0
        field.autocorrectionType = .no
        controller.textInsets(UIEdgeInsets.zero)
        viewParent.addSubview(field)
        NSLayoutConstraint.activate([
            field.leadingAnchor.constraint(equalTo: viewParent.leadingAnchor),
            field.rightAnchor.constraint(equalTo: viewParent.rightAnchor),
            field.topAnchor.constraint(equalTo: viewParent.topAnchor),
            field.bottomAnchor.constraint(equalTo: viewParent.bottomAnchor)
        ])
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Data Agen")
    }

}

extension DataAgenVC {
    
    private func disableButtonSelanjutnya() {
        buttonSelanjutnya.backgroundColor = UIColor.veryLightPink
        buttonSelanjutnya.isEnabled = false
    }
    
    private func checkInput() {
        if (fieldNamaAgen.text?.trim().isEmpty ?? false) {
            disableButtonSelanjutnya()
        } else if (fieldEmail.text?.trim().isEmpty ?? false) {
            disableButtonSelanjutnya()
        } else if (fieldAlamatAgen.text?.trim().isEmpty ?? false) {
            disableButtonSelanjutnya()
        } else if (fieldNomorTelepon.text?.trim().isEmpty ?? false) {
            disableButtonSelanjutnya()
        } else if (fieldNPWP.text?.trim().isEmpty ?? false) {
            disableButtonSelanjutnya()
        } else {
            buttonSelanjutnya.backgroundColor = UIColor.mediumGreen
            buttonSelanjutnya.isEnabled = true
        }
    }
    
    @IBAction func buttonSelanjutnyaClick(_ sender: Any) {
        daftarJadiAgenVM.namaAgen.accept(fieldNamaAgen.text ?? "")
        daftarJadiAgenVM.email.accept(fieldEmail.text ?? "")
        daftarJadiAgenVM.alamatAgen.accept(fieldAlamatAgen.text ?? "")
        daftarJadiAgenVM.nomorTelepon.accept(fieldNomorTelepon.text ?? "")
        daftarJadiAgenVM.npwp.accept(fieldNPWP.text ?? "")
        daftarJadiAgenVM.currentRencanaPerjalananPage.accept(1)
        daftarJadiAgenVM.maxRencanaPerjalananPage.accept(1)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        checkInput()
        
        if textField == fieldNamaAgen {
            controllerNamaAgen.floatingPlaceholderNormalColor = (textField.text?.trim().isEmpty ?? false) ? UIColor.veryLightPinkTwo : UIColor.mediumGreen
        } else if textField == fieldEmail {
            controllerEmail.floatingPlaceholderNormalColor = (textField.text?.trim().isEmpty ?? false) ? UIColor.veryLightPinkTwo : UIColor.mediumGreen
        } else if textField == fieldAlamatAgen {
            controllerAlamatAgen.floatingPlaceholderNormalColor = (textField.text?.trim().isEmpty ?? false) ? UIColor.veryLightPinkTwo : UIColor.mediumGreen
        } else if textField == fieldNomorTelepon {
            controllerNomorTelepon.floatingPlaceholderNormalColor = (textField.text?.trim().isEmpty ?? false) ? UIColor.veryLightPinkTwo : UIColor.mediumGreen
        } else if textField == fieldNPWP {
            controllerNPWP.floatingPlaceholderNormalColor = (textField.text?.trim().isEmpty ?? false) ? UIColor.veryLightPinkTwo : UIColor.mediumGreen
        }
    }
}
