//
//  RangkumanDaftarAgenVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 18/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import MaterialComponents.MaterialTextFields
import DIKit
import RxSwift

class RangkumanDaftarAgenVC: BaseViewController, IndicatorInfoProvider {

    @IBOutlet weak var buttonSelanjutnya: CustomButton!
    @IBOutlet weak var viewFieldNamaAgen: UIView!
    @IBOutlet weak var viewFieldEmail: UIView!
    @IBOutlet weak var viewFieldAlamat: UIView!
    @IBOutlet weak var viewFieldNomorTelepon: UIView!
    @IBOutlet weak var viewFieldNPWP: UIView!
    @IBOutlet weak var labelLegalDokumen: CustomLabel!
    @IBOutlet weak var viewLabelLegalDokumen: UIView!
    
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
    
    private var disposeBag = DisposeBag()
    @Inject private var daftarJadiAgenVM: DaftarJadiAgenVM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupEvent()
        
        observeData()
    }
    
    private func observeData() {
        daftarJadiAgenVM.fileName.subscribe(onNext: { value in
            if value != "" { self.labelLegalDokumen.text = value }
        }).disposed(by: disposeBag)
    }
    
    private func setupEvent() {
        viewLabelLegalDokumen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewLabelLegalDokumenClick)))
        fieldNamaAgen.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldAlamatAgen.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNomorTelepon.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNPWP.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func setupView() {
        fieldNamaAgen = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldEmail = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldEmail.keyboardType = .emailAddress
        fieldAlamatAgen = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNomorTelepon = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNomorTelepon.keyboardType = .phonePad
        fieldNPWP = MDCTextField(frame: CGRect(x: 0, y: 0, width: screenWidth - 48, height: 50))
        fieldNPWP.keyboardType = .numberPad
        
        fieldNamaAgen.text = daftarJadiAgenVM.namaAgen.value
        fieldEmail.text = daftarJadiAgenVM.email.value
        fieldAlamatAgen.text = daftarJadiAgenVM.alamatAgen.value
        fieldNomorTelepon.text = daftarJadiAgenVM.nomorTelepon.value
        fieldNPWP.text = daftarJadiAgenVM.npwp.value
        
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
        controller.floatingPlaceholderNormalColor = UIColor.mediumGreen
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

extension RangkumanDaftarAgenVC: UIDocumentPickerDelegate, DialogBerhasilKirimDataAgenProtocol {
    func dismisClick(vc: UIViewController) {
        vc.dismiss(animated: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func disableButtonSelanjutnya() {
        buttonSelanjutnya.backgroundColor = UIColor.veryLightPink
        buttonSelanjutnya.isEnabled = false
    }
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else { return }
        
        let data = try? Data(contentsOf: myURL)
        guard let _data = data else { return }
        let filename = "\(myURL)".components(separatedBy: "/").last ?? "\(PublicFunction.getCurrentMillis()).png"
        
        daftarJadiAgenVM.fileName.accept(filename)
        daftarJadiAgenVM.dataFile?.accept(_data)
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
        let vc = DialogBerhasilKirimDataAgen()
        vc.delegate = self
        showCustomDialog(vc)
    }
    
    @objc func viewLabelLegalDokumenClick() {
        let allowedFiles = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.audiovisual-content", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
        let importMenu = UIDocumentPickerViewController(documentTypes: allowedFiles, in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
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
