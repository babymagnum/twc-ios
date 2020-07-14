//
//  PembayaranVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DIKit
import RxSwift

class PembayaranVC: BaseViewController, IndicatorInfoProvider, UICollectionViewDelegate {

    @IBOutlet weak var labelTimer: CustomLabel!
    @IBOutlet weak var labelTotalDibayar: CustomLabel!
    @IBOutlet weak var collectionInternetBanking: UICollectionView!
    @IBOutlet weak var collectionInternetBankingHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonLihatSemuaInternetBanking: CustomButton!
    @IBOutlet weak var collectionATMTransfer: UICollectionView!
    @IBOutlet weak var collectionATMTransferHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonLihatSemuaATMTransfer: CustomButton!
    @IBOutlet weak var collectionEmoney: UICollectionView!
    @IBOutlet weak var collectionEmoneyHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionLainya: UICollectionView!
    @IBOutlet weak var collectionLainyaHeight: NSLayoutConstraint!
    
    @Inject private var pembayaranVM: PembayaranVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
        
        observeData()
    }
    
    private func observeData() {
        pembayaranVM.time.subscribe(onNext: { value in
            self.labelTimer.text = value
        }).disposed(by: disposeBag)
        
        pembayaranVM.listInternetBanking.subscribe(onNext: { value in
            self.collectionInternetBanking.reloadData()
            self.collectionInternetBanking.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionInternetBankingHeight.constant = self.collectionInternetBanking.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        pembayaranVM.listATMTransfer.subscribe(onNext: { value in
            self.collectionATMTransfer.reloadData()
            self.collectionATMTransfer.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionATMTransferHeight.constant = self.collectionATMTransfer.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        pembayaranVM.listEmoney.subscribe(onNext: { value in
            self.collectionEmoney.reloadData()
            self.collectionEmoney.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionEmoneyHeight.constant = self.collectionEmoney.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        pembayaranVM.listLainya.subscribe(onNext: { value in
            self.collectionLainya.reloadData()
            self.collectionLainya.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionLainyaHeight.constant = self.collectionLainya.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionInternetBanking.register(UINib(nibName: "MetodePembayaranCell", bundle: .main), forCellWithReuseIdentifier: "MetodePembayaranCell")
        collectionInternetBanking.delegate = self
        collectionInternetBanking.dataSource = self
        
        collectionATMTransfer.register(UINib(nibName: "MetodePembayaranCell", bundle: .main), forCellWithReuseIdentifier: "MetodePembayaranCell")
        collectionATMTransfer.delegate = self
        collectionATMTransfer.dataSource = self
        
        collectionEmoney.register(UINib(nibName: "MetodePembayaranCell", bundle: .main), forCellWithReuseIdentifier: "MetodePembayaranCell")
        collectionEmoney.delegate = self
        collectionEmoney.dataSource = self
        
        collectionLainya.register(UINib(nibName: "MetodePembayaranCell", bundle: .main), forCellWithReuseIdentifier: "MetodePembayaranCell")
        collectionLainya.delegate = self
        collectionLainya.dataSource = self
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Pembayaran")
    }

}

extension PembayaranVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionInternetBanking {
            return pembayaranVM.listInternetBanking.value.count
        } else if collectionView == collectionATMTransfer {
            return pembayaranVM.listATMTransfer.value.count
        } else if collectionView == collectionEmoney {
            return pembayaranVM.listEmoney.value.count
        } else {
            return pembayaranVM.listLainya.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionInternetBanking {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MetodePembayaranCell", for: indexPath) as! MetodePembayaranCell
            cell.item = pembayaranVM.listInternetBanking.value[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellInternetBankingClick(sender:))))
            return cell
        } else if collectionView == collectionATMTransfer {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MetodePembayaranCell", for: indexPath) as! MetodePembayaranCell
            cell.item = pembayaranVM.listATMTransfer.value[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellATMTransferClick(sender:))))
            return cell
        } else if collectionView == collectionEmoney {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MetodePembayaranCell", for: indexPath) as! MetodePembayaranCell
            cell.item = pembayaranVM.listEmoney.value[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellEmoneyClick(sender:))))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MetodePembayaranCell", for: indexPath) as! MetodePembayaranCell
            cell.item = pembayaranVM.listLainya.value[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellLainyaClick(sender:))))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight = screenWidth * 0.0853
        
        if collectionView == collectionInternetBanking {
            return CGSize(width: screenWidth, height: imageHeight + 13 + 13 + 1)
        } else if collectionView == collectionATMTransfer {
            return CGSize(width: screenWidth, height: imageHeight + 13 + 13 + 1)
        } else if collectionView == collectionEmoney {
            return CGSize(width: screenWidth, height: imageHeight + 13 + 13 + 1)
        } else {
            return CGSize(width: screenWidth, height: imageHeight + 13 + 13 + 1)
        }
    }
}

extension PembayaranVC {
    @objc func cellInternetBankingClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionInternetBanking.indexPathForItem(at: sender.location(in: collectionInternetBanking)) else { return }
    }
    
    @objc func cellATMTransferClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionATMTransfer.indexPathForItem(at: sender.location(in: collectionATMTransfer)) else { return }
    }
    
    @objc func cellEmoneyClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionEmoney.indexPathForItem(at: sender.location(in: collectionEmoney)) else { return }
    }
    
    @objc func cellLainyaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionLainya.indexPathForItem(at: sender.location(in: collectionLainya)) else { return }
    }
}
