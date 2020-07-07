//
//  BottomSheetPeserta.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 03/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit

class BottomSheetPeserta: BaseViewController, UIPickerViewDelegate {

    @IBOutlet weak var pickerViewDewasa: UIPickerView!
    @IBOutlet weak var pickerViewAnak: UIPickerView!
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    
    lazy var listAnak : [Int] = {
        var list = [Int]()
        for index in 0...20 { list.append(index) }
        return list
    }()
    
    lazy var listDewasa : [Int] = {
        var list = [Int]()
        for index in 0...20 { list.append(index) }
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let indexAnak = self.listAnak.firstIndex(of: self.rencanaPerjalananVM.pesertaAnak.value) ?? 0
        let indexDewasa = self.listDewasa.firstIndex(of: self.rencanaPerjalananVM.pesertaDewasa.value) ?? 0
        self.pickerViewAnak.selectRow(indexAnak, inComponent: 0, animated: true)
        self.pickerViewDewasa.selectRow(indexDewasa, inComponent: 0, animated: true)
    }
    
    private func setupView() {
        pickerViewDewasa.delegate = self
        pickerViewDewasa.dataSource = self
        pickerViewAnak.delegate = self
        pickerViewAnak.dataSource = self
        pickerViewDewasa.setValue(UIColor.mediumGreen, forKeyPath: "textColor")
        pickerViewAnak.setValue(UIColor.mediumGreen, forKeyPath: "textColor")
    }
}

extension BottomSheetPeserta: UIPickerViewDataSource {
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        if pickerView == pickerViewDewasa {
//            let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.mediumGreen : UIColor.black
//            return NSAttributedString(string: "\(listDewasa[row])", attributes: [NSAttributedString.Key.foregroundColor: color])
//        } else {
//            let color = (row == pickerView.selectedRow(inComponent: component)) ? UIColor.mediumGreen : UIColor.black
//            return NSAttributedString(string: "\(listAnak[row])", attributes: [NSAttributedString.Key.foregroundColor: color])
//        }
//    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerViewDewasa {
            return listDewasa.count
        } else {
            return listAnak.count
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // change this to match with multi array
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == pickerViewDewasa {
            return "\(listDewasa[row])"
        } else {
            return "\(listAnak[row])"
        }
        
        // return pickerData[component][row] // uncomment this code for multi array
    }
    
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if (picker == pickerViewDewasa) {
            // for multi array -> multiArray[component][row]
            // for single array -> singleArray[row]
            rencanaPerjalananVM.pesertaDewasa.accept(listDewasa[row])
        } else {
            rencanaPerjalananVM.pesertaAnak.accept(listAnak[row])
        }
        
    }
}
