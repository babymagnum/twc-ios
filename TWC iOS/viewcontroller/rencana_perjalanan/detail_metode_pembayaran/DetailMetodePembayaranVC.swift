//
//  DetailMetodePembayaranVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 16/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit
import RxSwift

class DetailMetodePembayaranVC: BaseViewController, UICollectionViewDelegate {

    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: CustomLabel!
    @IBOutlet weak var labelTotal: CustomLabel!
    @IBOutlet weak var labelAccountNumber: CustomLabel!
    @IBOutlet weak var labelAccountNumberValue: CustomLabel!
    @IBOutlet weak var collectionStep: UICollectionView!
    @IBOutlet weak var labelStep: CustomLabel!
    @IBOutlet weak var collectionStepHeight: NSLayoutConstraint!
    @IBOutlet weak var viewSalinKode: CustomView!
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    @Inject private var detailMetodePembayaranVM: DetailMetodePembayaranVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEvent()
        
        setupView()
        
        setupCollection()
        
        observeData()
        
        detailMetodePembayaranVM.generateStep()
    }
    
    private func setupEvent() {
        viewSalinKode.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewSalinKodeClick)))
    }
    
    private func setupView() {
        self.title = "Data pembayaran"
        navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
    }
    
    private func observeData() {
        detailMetodePembayaranVM.listStep.subscribe(onNext: { value in
            self.collectionStep.reloadData()
            self.collectionStep.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionStepHeight.constant = self.collectionStep.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionStep.delegate = self
        collectionStep.dataSource = self
        collectionStep.register(UINib(nibName: "BankTransferStepCell", bundle: .main), forCellWithReuseIdentifier: "BankTransferStepCell")
    }
    
}

extension DetailMetodePembayaranVC {
    @objc func viewSalinKodeClick() {
        UIPasteboard.general.string = "567 9865 8766 9000"
        self.view.makeToast("Text copied to clipboard")
    }
    
    @IBAction func konfirmasiPembayaranClick(_ sender: Any) {
        rencanaPerjalananVM.resetAllData()
        
        guard let rencanaPerjalananVC = self.navigationController?.viewControllers.last(where: { $0.isKind(of: RencanaPerjalananVC.self) }) else { return }
        let index = self.navigationController?.viewControllers.lastIndex(of: rencanaPerjalananVC) ?? 0
        
        navigationController?.viewControllers.remove(at: index)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func detailClick(_ sender: Any) {
        navigationController?.pushViewController(DetailHargaVC(), animated: true)
    }
    
    @IBAction func gantiClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailMetodePembayaranVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailMetodePembayaranVM.listStep.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankTransferStepCell", for: indexPath) as! BankTransferStepCell
        cell.item = detailMetodePembayaranVM.listStep.value[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = detailMetodePembayaranVM.listStep.value[indexPath.item]
        let contentHeight = item.content.getHeight(withConstrainedWidth: screenWidth - (24 * 2) - 20, font: UIFont(name: "SFProDisplay-Regular", size: 14 + PublicFunction.dynamicSize()))
        return CGSize(width: screenWidth, height: contentHeight)
    }
}
