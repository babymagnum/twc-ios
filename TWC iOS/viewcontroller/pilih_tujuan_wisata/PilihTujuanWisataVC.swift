//
//  PilihTujuanWisataVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import DIKit

class PilihTujuanWisataVC: BaseViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionCluster: UICollectionView!
    @IBOutlet weak var indicatorCluster: UIActivityIndicatorView!
    
    var selectedHari: Int?
    
    @Inject private var pilihTujuanWisataVM: PilihTujuanWisataVM
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupCollection()
        
        observeData()
        
        if pilihTujuanWisataVM.listCluster.value.count == 0 {
            pilihTujuanWisataVM.getCluster(nc: navigationController)
        }
    }
    
    private func observeData() {
        pilihTujuanWisataVM.listCluster.subscribe(onNext: { value in
            self.collectionCluster.reloadData()
            self.collectionCluster.layoutSubviews()
        }).disposed(by: disposeBag)
        
        pilihTujuanWisataVM.loadingCluster.subscribe(onNext: { value in
            self.indicatorCluster.isHidden = !value
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
        self.title = "Pilih tujuan wisata"
    }
    
    private func setupCollection() {
        collectionCluster.register(UINib(nibName: "ParentClusterCell", bundle: .main), forCellWithReuseIdentifier: "ParentClusterCell")
        collectionCluster.delegate = self
        collectionCluster.dataSource = self
    }
}

extension PilihTujuanWisataVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pilihTujuanWisataVM.listCluster.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParentClusterCell", for: indexPath) as! ParentClusterCell
        cell.item = pilihTujuanWisataVM.listCluster.value[indexPath.item]
        cell.selectedHari = selectedHari
        cell.nc = navigationController
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let titleHeight = "Cluster Yogyakarta".getHeight(withConstrainedWidth: screenWidth - 32, font: UIFont(name: "SFProDisplay-Bold", size: 18 + PublicFunction.dynamicSize()))
        let marginBot = (4 * pilihTujuanWisataVM.listCluster.value.count)
        return CGSize(width: screenWidth, height: (screenWidth * 0.43) + titleHeight + 32 + CGFloat(marginBot))
    }
}
