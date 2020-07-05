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
    private var listHari = [
        HariModel(name: "Hari 1", selected: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
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
    }
    
    @IBAction func tambahHariClick(_ sender: Any) {
        listHari.append(HariModel(name: "Hari \(listHari.count + 1)", selected: false))
        collectionHari.reloadData()
        collectionTujuanWisata.reloadData()
    }
    
    @objc func viewParentHariClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionHari.indexPathForItem(at: sender.location(in: collectionHari)) else { return }
        
        collectionTujuanWisata.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        for index in 0...listHari.count - 1 {
            if index == indexPath.item {
                listHari[index].selected = true
            } else {
                listHari[index].selected = false
            }
        }
        
        collectionHari.reloadData()
    }
}
