//
//  ParentClusterCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/09/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit

class ParentClusterCell: BaseCollectionViewCell, UICollectionViewDelegate {

    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var collectionSite: UICollectionView!
    @IBOutlet weak var buttonSelengkapnya: CustomButton!
    @IBOutlet weak var collectionSiteHeight: NSLayoutConstraint!
    
    private var listSite = [SiteData]()
    @Inject private var pilihTujuanWisataVM: PilihTujuanWisataVM
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    
    var nc: UINavigationController?
    var selectedHari: Int?
    var item: ClusterData? {
        didSet {
            if let _item = item {
                labelNama.text = _item.cluster_name
                listSite = _item.site ?? [SiteData]()
                collectionSite.reloadData()
                collectionSite.layoutSubviews()
                
                UIView.animate(withDuration: 0.2) {
                    self.collectionSiteHeight.constant = self.screenWidth * 0.43 + 4
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCollection()
    }

    private func initCollection() {
        collectionSite.register(UINib(nibName: "PilihTujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "PilihTujuanWisataCell")
        collectionSite.delegate = self
        collectionSite.dataSource = self
    }
}

extension ParentClusterCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PilihTujuanWisataCell", for: indexPath) as! PilihTujuanWisataCell
        cell.item = listSite[indexPath.item]
        cell.buttonAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonAddYogyakarta(sender:))))
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellYogyakartaClick(sender:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth * 0.7, height: screenWidth * 0.43)
    }
}

extension ParentClusterCell {
    private func addTujuanWisata(item: PilihanTujuanWisataModel) {
//        PublicFunction.showUnderstandDialog(self, item.name, "Yakin ingin menambah \(item.name) ke dalam tujuan wisata anda?", "Tambahkan", "Cancel") {
//            var newItem = item
//            newItem.id = UUID().uuidString
//            newItem.hari = self.selectedHari ?? 0
//
//            self.rencanaPerjalananVM.addTujuanWisata(tujuanWisata: newItem)
//        }
    }
    
    private func pushToDetailSite(indexPath: IndexPath) {
        let item = listSite[indexPath.item]
        
        let vc = DetailTempatWisataVC()
        vc.tujuanWisata = rencanaPerjalananVM.listTujuanWisata.value.last(where: { _item -> Bool in
            return _item.originId == "\(item.site_id ?? 0)" && _item.hari == selectedHari ?? 1
        })
        vc.selectedHari = selectedHari
        nc?.pushViewController(vc, animated: true)
    }
    
    @objc func cellYogyakartaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionSite.indexPathForItem(at: sender.location(in: collectionSite)) else { return }
        
        pushToDetailSite(indexPath: indexPath)
    }
    
    @objc func buttonAddYogyakarta(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionSite.indexPathForItem(at: sender.location(in: collectionSite)) else { return }
        
        pushToDetailSite(indexPath: indexPath)
        
//        guard let indexPath = collectionYogyakarta.indexPathForItem(at: sender.location(in: collectionYogyakarta)) else { return }
//        addTujuanWisata(item: pilihTujuanWisataVM.listYogyakarta.value[indexPath.item])
    }
}
