//
//  DataPesertaVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 07/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DropDown
import DIKit

class DataPesertaVC: BaseViewController {

    var selectedIndex: Int!
    
    @IBOutlet weak var buttonSelesai: CustomButton!
    @IBOutlet weak var marginTopDataKontakPerson: NSLayoutConstraint!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var labelTipeIdentitas: CustomLabel!
    @IBOutlet weak var viewTipeIdentitas: UIView!
    @IBOutlet weak var fieldNomorIdentitas: CustomTextField!
    @IBOutlet weak var labelTitle: CustomLabel!
    @IBOutlet weak var viewTitel: UIView!
    @IBOutlet weak var fieldNamaLengkap: CustomTextField!
    @IBOutlet weak var viewCheckbox: CustomView!
    @IBOutlet weak var imageCheckbox: CustomImage!
    @IBOutlet weak var fieldNomorHandphone: CustomTextField!
    @IBOutlet weak var fieldEmail: CustomTextField!
    @IBOutlet weak var fieldAlamat: CustomTextField!
    @IBOutlet weak var viewDataKontakPerson: UIView!
    @IBOutlet weak var heightDataKontakPerson: NSLayoutConstraint!
    @IBOutlet weak var viewSetSebagaiKontakPerson: UIView!
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private let dropDownTipeIdentitas = DropDown()
    private let dropDownTitel = DropDown()
    private var setKontakPerson = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupEvent()
    }
        
    private func setupEvent() {
        fieldNomorIdentitas.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNamaLengkap.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldNomorHandphone.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldEmail.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fieldAlamat.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        viewTipeIdentitas.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTipeIdentitasClick)))
        viewTitel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTitelClick)))
        viewSetSebagaiKontakPerson.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewSetSebagaiKontakPersonClick)))
    }

    private func setDropdownShadow(dropdown: DropDown) {
        dropdown.textColor = UIColor.black
        dropdown.textFont = UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize()) ?? UIFont.systemFont(ofSize: 16 + PublicFunction.dynamicSize())
        dropdown.selectionBackgroundColor = UIColor.clear
        dropdown.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        dropdown.shadowColor = UIColor.black.withAlphaComponent(0.16)
        dropdown.shadowOffset = CGSize(width: 1, height: 2)
        dropdown.shadowRadius = 3
        dropdown.shadowOpacity = 1
        dropdown.backgroundColor = UIColor.white.withAlphaComponent(0.92)
        dropdown.cornerRadius = 8
        dropdown.layoutMarginsDidChange()
    }
    
    private func enableDisableButtonSelesai(enable: Bool) {
        buttonSelesai.isEnabled = enable
        buttonSelesai.backgroundColor = enable ? UIColor.mediumGreen : UIColor.veryLightPinkTwo
    }
    
    private func checkInput() {
        if labelTipeIdentitas.text == "Tipe identitas" {
            enableDisableButtonSelesai(enable: false)
        } else if fieldNomorIdentitas.trim() == "" {
            enableDisableButtonSelesai(enable: false)
        } else if labelTitle.text == "Titel" {
            enableDisableButtonSelesai(enable: false)
        } else if fieldNamaLengkap.trim() == "" {
            enableDisableButtonSelesai(enable: false)
        } else if setKontakPerson {
            if fieldNomorHandphone.trim() == "" {
                enableDisableButtonSelesai(enable: false)
            } else if fieldEmail.trim() == "" {
                enableDisableButtonSelesai(enable: false)
            } else if fieldAlamat.trim() == "" {
                enableDisableButtonSelesai(enable: false)
            } else {
                enableDisableButtonSelesai(enable: true)
            }
        } else {
            enableDisableButtonSelesai(enable: true)
        }
    }
    
    private func setupView() {
        self.title = "Data peserta"
        navigationController?.isNavigationBarHidden = false
        heightDataKontakPerson.constant = 0

        /// setup data
        let item = rencanaPerjalananVM.listDataPeserta.value[selectedIndex]
        
        labelPeserta.text = item.peserta
        
        if item.isFilled {
            labelTipeIdentitas.text = item.tipeIdentitas
            fieldNomorIdentitas.text = item.nomorIdentitas
            labelTitle.text = item.title
            fieldNamaLengkap.text = item.nama
            
            if item.isKontak {
                showHideKontakPerson()
                let kontakPerson = rencanaPerjalananVM.dataKontakPerson.value
                fieldNomorHandphone.text = kontakPerson.nomorHandphone
                fieldEmail.text = kontakPerson.email
                fieldAlamat.text = kontakPerson.alamat
            }
        }
        
        checkInput()
        
        /// setup dropdown
        setDropdownShadow(dropdown: dropDownTitel)
        setDropdownShadow(dropdown: dropDownTipeIdentitas)
        
        dropDownTipeIdentitas.anchorView = viewTipeIdentitas
        dropDownTitel.anchorView = viewTitel

        dropDownTipeIdentitas.dataSource = ["KTP", "Passport"]
        dropDownTitel.dataSource = ["Tuan", "Nyonya", "Nona"]
        
        dropDownTipeIdentitas.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.labelTipeIdentitas.text = item
            self.checkInput()
            self.dropDownTipeIdentitas.hide()
        }
        
        dropDownTitel.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.labelTitle.text = item
            self.checkInput()
            self.dropDownTitel.hide()
        }
    }
}

extension DataPesertaVC {
    @objc func textFieldDidChange(textfield: UITextField) {
        checkInput()
    }
    
    @IBAction func selesaiClick(_ sender: Any) {
        /// update selected data peserta
        let oldData = rencanaPerjalananVM.listDataPeserta.value[selectedIndex]
        rencanaPerjalananVM.updateDataPeserta(selectedIndex: selectedIndex, newData: DataPesertaModel(nama: fieldNamaLengkap.trim(), peserta: oldData.nama, title: labelTitle.text ?? "", nomorIdentitas: fieldNomorIdentitas.trim(), isKontak: setKontakPerson, tipeIdentitas: labelTipeIdentitas.text ?? "", isFilled: true))
        
        /// update data kontak person
        if setKontakPerson {
            rencanaPerjalananVM.dataKontakPerson.accept(DataKontakPerson(nomorHandphone: fieldNomorHandphone.trim(), email: fieldEmail.trim(), alamat: fieldAlamat.trim()))
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func showHideKontakPerson() {
        setKontakPerson = !setKontakPerson
        
        UIView.animate(withDuration: 0.2) {
            self.marginTopDataKontakPerson.constant = self.setKontakPerson ? 16 : 0
            self.viewCheckbox.giveBorder(self.setKontakPerson ? 0 : 2, self.setKontakPerson ? UIColor.clear : UIColor.blackThree.withAlphaComponent(0.5))
            self.viewCheckbox.backgroundColor = self.setKontakPerson ? UIColor.mediumGreen : UIColor.clear
            self.imageCheckbox.isHidden = !self.setKontakPerson
            self.viewDataKontakPerson.isHidden = !self.setKontakPerson
            self.heightDataKontakPerson.constant = self.setKontakPerson ? 10000 : 0
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func viewSetSebagaiKontakPersonClick() {
        showHideKontakPerson()
    }
    
    @objc func viewTipeIdentitasClick() {
        dropDownTipeIdentitas.show()
    }
    
    @objc func viewTitelClick() {
        dropDownTitel.show()
    }
}
