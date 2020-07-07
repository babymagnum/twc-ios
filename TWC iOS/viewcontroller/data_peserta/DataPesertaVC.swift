//
//  DataPesertaVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 07/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DropDown

class DataPesertaVC: BaseViewController {

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
    
    private let dropDownTipeIdentitas = DropDown()
    private let dropDownTitel = DropDown()
    private var setKontakPerson = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupEvent()
    }
    
    private func setupEvent() {
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
    
    private func setupView() {
        self.title = "Data peserta"
        navigationController?.isNavigationBarHidden = false
        heightDataKontakPerson.constant = 0

        setDropdownShadow(dropdown: dropDownTitel)
        setDropdownShadow(dropdown: dropDownTipeIdentitas)
        
        // The view to which the drop down will appear on
        dropDownTipeIdentitas.anchorView = viewTipeIdentitas
        dropDownTitel.anchorView = viewTitel

        // The list of items to display. Can be changed dynamically
        dropDownTipeIdentitas.dataSource = ["KTP", "Passport"]
        dropDownTitel.dataSource = ["Tuan", "Nyonya", "Nona"]
        
        dropDownTipeIdentitas.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropDownTipeIdentitas.hide()
        }
        
        dropDownTitel.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropDownTitel.hide()
        }
    }
}

extension DataPesertaVC {
    @objc func viewSetSebagaiKontakPersonClick() {
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
    
    @objc func viewTipeIdentitasClick() {
        dropDownTipeIdentitas.show()
    }
    
    @objc func viewTitelClick() {
        dropDownTitel.show()
    }
}
