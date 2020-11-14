//
//  BerandaVC.swift
//  Eoviz Presence
//
//  Created by Arief Zainuri on 10/04/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit
import RxSwift
import SVProgressHUD
import GoogleMaps

class BerandaVC: BaseViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionPaketFavoriteHeight: NSLayoutConstraint!
    @IBOutlet weak var imageTopMargin: NSLayoutConstraint!
    @IBOutlet weak var buttonTanggalMulai: CustomButton!
    @IBOutlet weak var buttonTanggalSelesai: CustomButton!
    @IBOutlet weak var buttonDewasa: CustomButton!
    @IBOutlet weak var buttonAnak: CustomButton!
    @IBOutlet weak var collectionPaketFavorit: UICollectionView!
    @IBOutlet weak var loadingPaketFavorite: UIActivityIndicatorView!
    
    @Inject private var berandaVM: BerandaVM
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("screen width \(screenWidth)")
        print("token \(preference.getString(key: constant.TOKEN))")
        
        setupView()
        
        setupCollection()
        
        observeData()
        
        berandaVM.getPaketFavorite()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        observeData()
    }
    
    private func observeData() {
        rencanaPerjalananVM.pesertaDewasa.subscribe(onNext: { value in
            self.buttonDewasa.setTitle("\(value) dewasa", for: .normal)
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.pesertaAnak.subscribe(onNext: { value in
            self.buttonAnak.setTitle("\(value) anak", for: .normal)
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.selectedDates.subscribe(onNext: { value in
            self.buttonTanggalMulai.setTitle(PublicFunction.dateToString(value.first ?? Date(), "EEE, dd MMM yyyy"), for: .normal)
            self.buttonTanggalSelesai.setTitle(PublicFunction.dateToString(value.last ?? Date(), "EEE, dd MMM yyyy"), for: .normal)
        }).disposed(by: disposeBag)
        
        berandaVM.listPaketFavorite.subscribe(onNext: { value in
            self.collectionPaketFavorit.reloadData()
            self.collectionPaketFavorit.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.loadingPaketFavorite.isHidden = value.count > 0
                self.collectionPaketFavoriteHeight.constant = self.collectionPaketFavorit.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionPaketFavorit.register(UINib(nibName: "PaketFavoritCell", bundle: .main), forCellWithReuseIdentifier: "PaketFavoritCell")
        collectionPaketFavorit.delegate = self
        collectionPaketFavorit.dataSource = self
    }
    
    private func setupView() {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        
        imageTopMargin.constant = -statusBarHeight
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

extension BerandaVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return berandaVM.listPaketFavorite.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaketFavoritCell", for: indexPath) as! PaketFavoritCell
        cell.item = berandaVM.listPaketFavorite.value[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = berandaVM.listPaketFavorite.value[indexPath.item]
        let favoriteHeight = screenWidth * 0.053
        let marginHorizontal = screenWidth * 0.064
        let titleHeight = item.name?.getHeight(withConstrainedWidth: screenWidth - (marginHorizontal * 4), font: UIFont(name: "Nunito-Bold", size: 16 + PublicFunction.dynamicSize())) ?? 0
        let originPriceHeight = item.originPrice?.getHeight(withConstrainedWidth: screenWidth - (marginHorizontal * 4), font: UIFont(name: "Nunito-Regular", size: 12 + PublicFunction.dynamicSize())) ?? 0
        let discountPriceHeight = item.discountPrice?.getHeight(withConstrainedWidth: screenWidth - (marginHorizontal * 4), font: UIFont(name: "Nunito-Bold", size: 16 + PublicFunction.dynamicSize())) ?? 0
        return CGSize(width: screenWidth - (marginHorizontal * 2), height: 61 + favoriteHeight + titleHeight + originPriceHeight + discountPriceHeight + marginHorizontal)
    }
}

extension BerandaVC {
    @IBAction func selengkapnyaClick(_ sender: Any) {
    }
    
    @IBAction func anakClick(_ sender: Any) {
        showBottomSheet(vc: BottomSheetPeserta(), handleColor: UIColor.clear, height: screenHeight * 0.6)
    }
    
    @IBAction func dewasaClick(_ sender: Any) {
        showBottomSheet(vc: BottomSheetPeserta(), handleColor: UIColor.clear, height: screenHeight * 0.6)
    }
    
    @IBAction func tanggalSelesaiClick(_ sender: Any) {
        showBottomSheet(vc: BottomSheetTanggalVC(), handleColor: UIColor.clear, height: screenHeight * 0.85)
    }
    
    @IBAction func tanggalMulaiClick(_ sender: Any) {
        showBottomSheet(vc: BottomSheetTanggalVC(), handleColor: UIColor.clear, height: screenHeight * 0.85)
    }
    
    @IBAction func rencanakanPerjalananClick(_ sender: Any) {
        let pesertaDewasa = rencanaPerjalananVM.pesertaDewasa.value
        
        if pesertaDewasa == 0 {
            self.view.makeToast("Minimal perjalanan adalah untuk 1 orang dewasa.")
        } else {
            navigationController?.pushViewController(RencanaPerjalananVC(), animated: true)
        }
    }
}
