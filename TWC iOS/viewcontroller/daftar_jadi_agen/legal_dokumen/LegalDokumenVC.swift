//
//  LegalDokumenVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 18/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DIKit
import RxSwift

class LegalDokumenVC: BaseViewController, IndicatorInfoProvider {

    @IBOutlet weak var buttonSelanjutnya: CustomButton!
    @IBOutlet weak var viewParentLegalDokumen: CustomView!
    @IBOutlet weak var labelLegalDokumen: CustomLabel!
    
    @Inject private var daftarJadiAgenVM: DaftarJadiAgenVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupEvent()
        
        observeData()
    }
    
    private func observeData() {
        daftarJadiAgenVM.fileName.subscribe(onNext: { value in
            self.buttonSelanjutnya.backgroundColor = value == "" ? UIColor.veryLightPink : UIColor.mediumGreen
            self.buttonSelanjutnya.isEnabled = value != ""
            
            if value != "" {
                self.labelLegalDokumen.text = value
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupEvent() {
        viewParentLegalDokumen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewParentLegalDokumenClick)))
    }
    
    private func setupView() {
        buttonSelanjutnya.isEnabled = false
        buttonSelanjutnya.backgroundColor = UIColor.veryLightPink
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Legal Dokumen")
    }
}

extension LegalDokumenVC: UIDocumentPickerDelegate {
    
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else { return }
        
        let data = try? Data(contentsOf: myURL)
        guard let _data = data else { return }
        let filename = "\(myURL)".components(separatedBy: "/").last ?? "\(PublicFunction.getCurrentMillis()).png"
        
        daftarJadiAgenVM.fileName.accept(filename)
        daftarJadiAgenVM.dataFile?.accept(_data)
    }
    
    @objc func viewParentLegalDokumenClick() {
        let allowedFiles = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.audiovisual-content", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
        let importMenu = UIDocumentPickerViewController(documentTypes: allowedFiles, in: .import)
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        self.present(importMenu, animated: true, completion: nil)
    }
    
    @IBAction func buttonSelanjutnyaClick(_ sender: Any) {
        daftarJadiAgenVM.currentRencanaPerjalananPage.accept(2)
        daftarJadiAgenVM.maxRencanaPerjalananPage.accept(2)
    }
}
