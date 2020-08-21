//
//  RangkumanVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import DIKit

class RangkumanVC: BaseViewController, IndicatorInfoProvider, UICollectionViewDelegate {

    @IBOutlet weak var collectionRencanaPerjalanan: UICollectionView!
    @IBOutlet weak var collectionRencanaPerjalananHeight: NSLayoutConstraint!
    @IBOutlet weak var viewSimpanPaketFavorite: UIView!
    @IBOutlet weak var labelObjekWisata: CustomLabel!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var labelTotalPeserta: CustomLabel!
    @IBOutlet weak var labelDiskon: CustomLabel!
    @IBOutlet weak var labelTotal: CustomLabel!
    @IBOutlet weak var collectionDataPeserta: UICollectionView!
    @IBOutlet weak var collectionDataPesertaHeight: NSLayoutConstraint!
    
    @Inject private var pembayaranVM: PembayaranVM
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        
        observeData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        observeData()
    }
    
    private func observeData() {
        rencanaPerjalananVM.listRencanaPerjalanan.subscribe(onNext: { value in
            self.collectionRencanaPerjalanan.reloadData()
            self.collectionRencanaPerjalanan.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionRencanaPerjalananHeight.constant = self.collectionRencanaPerjalanan.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.listDataPeserta.subscribe(onNext: { value in
            self.labelPeserta.text = "Total (x\(value.count) peserta)"
            self.collectionDataPeserta.reloadData()
            self.collectionDataPeserta.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionDataPesertaHeight.constant = self.collectionDataPeserta.contentSize.height
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.listTujuanWisata.subscribe(onNext: { value in
            var hargaTiket = 0
            let totalPeserta = self.rencanaPerjalananVM.listDataPeserta.value.count
            
            value.forEach { item in
                item.listTicket.forEach { itemTiket in
                    hargaTiket += itemTiket.harga * itemTiket.peserta
                }
            }
            
            self.labelObjekWisata.text = PublicFunction.prettyRupiah("\(hargaTiket)")
            self.labelTotalPeserta.text = PublicFunction.prettyRupiah("\(hargaTiket * totalPeserta)")
            self.labelTotal.text = PublicFunction.prettyRupiah("\(hargaTiket * totalPeserta)")
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionRencanaPerjalanan.register(UINib(nibName: "RencanaPerjalananCell", bundle: .main), forCellWithReuseIdentifier: "RencanaPerjalananCell")
        collectionRencanaPerjalanan.register(UINib(nibName: "RencanaPerjalananTempatCell", bundle: .main), forCellWithReuseIdentifier: "RencanaPerjalananTempatCell")
        collectionDataPeserta.register(UINib(nibName: "DataPesertaCell", bundle: .main), forCellWithReuseIdentifier: "DataPesertaCell")
        collectionRencanaPerjalanan.delegate = self
        collectionRencanaPerjalanan.dataSource = self
        collectionDataPeserta.delegate = self
        collectionDataPeserta.dataSource = self
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Rangkuman")
    }
    
}

extension RangkumanVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionRencanaPerjalanan {
            return rencanaPerjalananVM.listRencanaPerjalanan.value.count
        } else {
            return rencanaPerjalananVM.listDataPeserta.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionRencanaPerjalanan {
            let item = rencanaPerjalananVM.listRencanaPerjalanan.value[indexPath.item]
            
            if item is RencanaPerjalananHariModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RencanaPerjalananCell", for: indexPath) as! RencanaPerjalananCell
                cell.item = item as? RencanaPerjalananHariModel
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RencanaPerjalananTempatCell", for: indexPath) as! RencanaPerjalananTempatCell
                let itemTempat = item as? RencanaPerjalananTempatModel
                cell.item = itemTempat
                
                let itemBefore = rencanaPerjalananVM.listRencanaPerjalanan.value[indexPath.item - 1]
                let itemAfter = indexPath.item + 1 == rencanaPerjalananVM.listRencanaPerjalanan.value.count ? nil : rencanaPerjalananVM.listRencanaPerjalanan.value[indexPath.item + 1]
                
                if itemBefore is RencanaPerjalananHariModel && itemAfter is RencanaPerjalananHariModel {
                    if itemBefore is RencanaPerjalananTempatModel && itemAfter is RencanaPerjalananTempatModel {
                        cell.viewLineTop.isHidden = false
                        cell.viewLineBot.isHidden = false
                    } else if itemBefore is RencanaPerjalananHariModel && itemAfter is RencanaPerjalananTempatModel {
                        cell.viewLineTop.isHidden = true
                        cell.viewLineBot.isHidden = false
                    } else if itemBefore is RencanaPerjalananTempatModel && itemAfter is RencanaPerjalananHariModel {
                        cell.viewLineTop.isHidden = false
                        cell.viewLineBot.isHidden = true
                    } else {
                        cell.viewLineTop.isHidden = true
                        cell.viewLineBot.isHidden = true
                    }
                } else {
                    if itemBefore is RencanaPerjalananHariModel && itemAfter is RencanaPerjalananTempatModel {
                        cell.viewLineTop.isHidden = true
                        cell.viewLineBot.isHidden = false
                    } else if itemBefore is RencanaPerjalananTempatModel && itemAfter is RencanaPerjalananTempatModel {
                        cell.viewLineTop.isHidden = false
                        cell.viewLineBot.isHidden = false
                    } else if itemBefore is RencanaPerjalananTempatModel && itemAfter is RencanaPerjalananHariModel {
                        cell.viewLineTop.isHidden = false
                        cell.viewLineBot.isHidden = true
                    } else if itemBefore is RencanaPerjalananTempatModel && itemAfter == nil {
                        cell.viewLineTop.isHidden = false
                        cell.viewLineBot.isHidden = true
                    } else {
                        cell.viewLineTop.isHidden = true
                        cell.viewLineBot.isHidden = true
                    }
                }
                
                cell.viewDivider.isHidden = indexPath.item == rencanaPerjalananVM.listRencanaPerjalanan.value.count - 1
                
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataPesertaCell", for: indexPath) as! DataPesertaCell
            cell.item = rencanaPerjalananVM.listDataPeserta.value[indexPath.item]
            cell.viewDivider.isHidden = indexPath.item == rencanaPerjalananVM.listDataPeserta.value.count - 1
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellDataPesertaClick(sender:))))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionRencanaPerjalanan {
            let item = rencanaPerjalananVM.listRencanaPerjalanan.value[indexPath.item]
            
            if item is RencanaPerjalananHariModel {
                let itemHari = item as? RencanaPerjalananHariModel
                let hariHeight = itemHari?.nama.getHeight(withConstrainedWidth: screenWidth - (8 * 2) - (41 + 16), font: UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize())) ?? 0
                return CGSize(width: screenWidth - 16, height: hariHeight + 41)
            } else {
                let itemTempat = item as? RencanaPerjalananTempatModel
                let namaHeight = itemTempat?.nama.getHeight(withConstrainedWidth: screenWidth - (8 * 2) - 57, font: UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize())) ?? 0
                let durasiHeight = itemTempat?.typePeserta.getHeight(withConstrainedWidth: screenWidth - (8 * 2) - 57, font: UIFont(name: "SFProDisplay-Regular", size: 12 + PublicFunction.dynamicSize())) ?? 0
                return CGSize(width: screenWidth - 16, height: namaHeight + durasiHeight + 37)
            }
        } else {
            let item = rencanaPerjalananVM.listDataPeserta.value[indexPath.item]
            let namaHeight = item.nama.getHeight(withConstrainedWidth: screenWidth - (16 * 2) - (16 + 45), font: UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize()))
            let nikHeight = "546780456000022".getHeight(withConstrainedWidth: screenWidth - (16 * 2) - (16 + 45), font: UIFont(name: "SFProDisplay-Regular", size: 14 + PublicFunction.dynamicSize()))
            return CGSize(width: screenWidth - (8 * 2) - (16 * 2), height: namaHeight + nikHeight + 30)
        }
    }
}

extension RangkumanVC {
    
    private func allowToNext() -> Bool {
        var emptyKontakPerson = true
        var emptyDataPeserta = false
        
        rencanaPerjalananVM.listDataPeserta.value.forEach { item in
            if emptyKontakPerson && item.isKontak {
                emptyKontakPerson = false
            }
            
            if !emptyDataPeserta && item.nomorIdentitas == "" {
                emptyDataPeserta = true
            }
        }
        
        if emptyDataPeserta {
            PublicFunction.showUnderstandDialog(self, "Oops", "Anda belum melengkapi data peserta", "Ok")
            return false
        } else if emptyKontakPerson {
            PublicFunction.showUnderstandDialog(self, "Oops", "Anda belum menentukan kontak person", "Ok")
            return false
        } else {
            return true
        }
    }
    
    @IBAction func bayarClick(_ sender: Any) {
        if allowToNext() {
            PublicFunction.showUnderstandDialog(self, "Konfirmasi", "Apakah anda yakin rencana perjalanan anda sudah benar?", "Ya", "Batal") {
                self.rencanaPerjalananVM.currentRencanaPerjalananPage.accept(3)
                self.rencanaPerjalananVM.maxRencanaPerjalananPage.accept(3)
                self.pembayaranVM.generateMetodePembayaran()
                self.pembayaranVM.startTimer()
            }
        }
    }
    
    @IBAction func simpanDuluClick(_ sender: Any) {
        if allowToNext() {
            print("next")
        }
    }
    
    @objc func cellDataPesertaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionDataPeserta.indexPathForItem(at: sender.location(in: collectionDataPeserta)) else { return }
        
        let vc = DataPesertaVC()
        vc.selectedIndex = indexPath.item
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
