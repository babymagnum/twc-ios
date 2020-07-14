//
//  TujuanWisataVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DIKit
import RxSwift

class TujuanWisataVC: BaseViewController, IndicatorInfoProvider, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionHari: UICollectionView!
    @IBOutlet weak var collectionTujuanWisata: UICollectionView!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var labelHarga: CustomLabel!
    @IBOutlet weak var collectionHariHeight: NSLayoutConstraint!
    
    private var disposeBag = DisposeBag()
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var listHari = [HariModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        
        observeData()
    }
    
    private func observeData() {
        rencanaPerjalananVM.selectedDates.subscribe(onNext: { value in
            self.listHari.removeAll()
            
            for (index, _) in value.enumerated() {
                self.listHari.append(HariModel(name: "Hari \(index + 1)", selected: index == 0))
            }
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.pesertaDewasa.subscribe(onNext: { value in
            let anak = self.rencanaPerjalananVM.pesertaAnak.value
            self.labelPeserta.text = "Total harga untuk \(value) dewasa\(anak == 0 ? "" : ", \(anak) anak")"
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.pesertaAnak.subscribe(onNext: { value in
            let dewasa = self.rencanaPerjalananVM.pesertaDewasa.value
            self.labelPeserta.text = "Total harga untuk \(dewasa) dewasa\(value == 0 ? "" : ", \(value) anak")"
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.listTujuanWisata.subscribe(onNext: { value in
            var totalHarga = 0
            let totalPeserta = self.rencanaPerjalananVM.pesertaAnak.value + self.rencanaPerjalananVM.pesertaDewasa.value
            
            value.forEach { item in
                totalHarga += item.harga
            }
            
            self.labelHarga.text = PublicFunction.prettyRupiah("\(totalHarga * totalPeserta)")
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionHari.register(UINib(nibName: "HariCell", bundle: .main), forCellWithReuseIdentifier: "HariCell")
        collectionTujuanWisata.register(UINib(nibName: "ParentTujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "ParentTujuanWisataCell")
        collectionHari.delegate = self
        collectionHari.dataSource = self
        collectionTujuanWisata.delegate = self
        collectionTujuanWisata.dataSource = self
        collectionTujuanWisata.isScrollEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.collectionHariHeight.constant = self.collectionHari.contentSize.height
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Tujuan Wisata")
    }
}

extension TujuanWisataVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listHari.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionHari {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HariCell", for: indexPath) as! HariCell
            cell.item = listHari[indexPath.item]
            cell.viewParent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewParentHariClick(sender:))))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParentTujuanWisataCell", for: indexPath) as! ParentTujuanWisataCell
            cell.hari = indexPath.item + 1
            cell.viewController = self
            cell.navigationController = self.navigationController
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionHari {
            let item = listHari[indexPath.item]
            return CGSize(width: 40 + item.name.getWidth(font: UIFont(name: "SFProDisplay-Regular", size: 14 + PublicFunction.dynamicSize())), height: screenWidth * 0.05)
        } else {
            return CGSize(width: screenWidth, height: collectionTujuanWisata.frame.height)
        }
    }
}

extension TujuanWisataVC {
    @IBAction func selanjutnyaClick(_ sender: Any) {
        var _listFilledDays = [Int]()
        var _listEmptyDays = [Int]()
        var _days = ""
        
        rencanaPerjalananVM.listTujuanWisata.value.forEach { item in
            if !_listFilledDays.contains(item.hari) {
                _listFilledDays.append(item.hari)
            }
        }
        
        for index in 0...listHari.count - 1 {
            if !_listFilledDays.contains(index + 1) {
                _listEmptyDays.append(index + 1)
            }
        }
        
        _listEmptyDays.forEach { item in
            _days += "\(item), "
        }
        
        if rencanaPerjalananVM.listTujuanWisata.value.count == 0 {
            self.view.makeToast("Anda belum memilih tujuan wisata")
        } else if _listEmptyDays.count > 0 {
            let index = (_listEmptyDays.first ?? 1) - 1
            self.view.makeToast("Anda belum memilih tujuan wisata pada hari ke \(_days.dropLast(2))")
            changeHariAndScrollTujuanWisata(indexPath: IndexPath(item: index, section: 0))
        } else {
            rencanaPerjalananVM.generateRencanaPerjalanan()
            rencanaPerjalananVM.generateDataPeserta()
            rencanaPerjalananVM.currentRencanaPerjalananPage.accept(1)
            rencanaPerjalananVM.maxRencanaPerjalananPage.accept(1)
        }
    }
    
    @IBAction func tambahHariClick(_ sender: Any) {
        listHari.append(HariModel(name: "Hari \(listHari.count + 1)", selected: false))
        collectionHari.reloadData()
        collectionHari.layoutSubviews()
        collectionTujuanWisata.reloadData()
        collectionTujuanWisata.layoutSubviews()
        
        /// Add data to selected dates in ViewModel
        let addedDate = Calendar.current.date(byAdding: .day, value: 1, to: rencanaPerjalananVM.selectedDates.value.last ?? Date()) ?? Date()
        print("added date \(PublicFunction.dateToString(addedDate, "dd MMMM yyyy"))")
        var _selectedDates = rencanaPerjalananVM.selectedDates.value
        _selectedDates.append(addedDate)
        rencanaPerjalananVM.selectedDates.accept(_selectedDates)
    }
    
    @objc func viewParentHariClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionHari.indexPathForItem(at: sender.location(in: collectionHari)) else { return }
        
        changeHariAndScrollTujuanWisata(indexPath: indexPath)
    }
    
    private func changeHariAndScrollTujuanWisata(indexPath: IndexPath) {
        collectionTujuanWisata.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        for index in 0...listHari.count - 1 {
            if index == indexPath.item {
                listHari[index].selected = true
            } else {
                listHari[index].selected = false
            }
        }
        
        collectionHari.reloadData()
        collectionHari.layoutSubviews()
    }
}
