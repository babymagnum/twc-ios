//
//  ParentTujuanWisataCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import DIKit
import RxSwift

class ParentTujuanWisataCell: BaseCollectionViewCell, UICollectionViewDelegate {

    @IBOutlet weak var collectionTujuanWisata: UICollectionView!
    @IBOutlet weak var collectionTujuanWisataHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTambahTujuanWisata: CustomView!
    @IBOutlet weak var viewEmpty: UIView!
    @IBOutlet weak var viewEmptyHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionTujuanWisataMarginTop: NSLayoutConstraint!
    
    var hari: Int? {
        didSet {
            if let _hari = hari {
                observeData(hari: _hari)
            }
        }
    }
    
    private var disposeBag = DisposeBag()
    var listTujuanWisata = [TujuanWisataModel]()
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    
    override func awakeFromNib() {
        super.awakeFromNib()                
        
        setupCollection()
        
        setupEvent()
    }
    
    private func setupEvent() {
        viewTambahTujuanWisata.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTambahTujuanWisataClick)))
    }
    
    private func observeData(hari: Int) {
        rencanaPerjalananVM.listTujuanWisata.subscribe(onNext: { value in
            self.listTujuanWisata.removeAll()
            
            value.forEach { item in
                if item.hari == hari { self.listTujuanWisata.append(item) }
            }
            
            self.collectionTujuanWisata.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.2) {
                    self.collectionTujuanWisataMarginTop.constant = self.listTujuanWisata.count == 0 ? 0 : 10
                    self.viewEmptyHeight.constant = self.listTujuanWisata.count == 0 ? 1000 : 0
                    self.viewEmpty.isHidden = self.listTujuanWisata.count > 0
                    self.collectionTujuanWisataHeight.constant = self.collectionTujuanWisata.contentSize.height
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        collectionTujuanWisataMarginTop.constant = 0
        collectionTujuanWisataHeight.constant = 0
        collectionTujuanWisata.register(UINib(nibName: "TujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "TujuanWisataCell")
        collectionTujuanWisata.delegate = self
        collectionTujuanWisata.dataSource = self
    }
}

extension ParentTujuanWisataCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTujuanWisata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TujuanWisataCell", for: indexPath) as! TujuanWisataCell
        cell.item = listTujuanWisata[indexPath.item]
        cell.buttonHapus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonHapusClick(sender:))))
        cell.buttonMin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonMinClick(sender:))))
        cell.buttonPlus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonPlusClick(sender:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = screenWidth * 0.2
        let item = listTujuanWisata[indexPath.item]
        let titleHeight = item.name.getHeight(withConstrainedWidth: screenWidth - (24 * 2) - imageSize - (10 + 24), font: UIFont(name: "Nunito-Bold", size: 16 + PublicFunction.dynamicSize()))
        let hargaHeight = item.harga.getHeight(withConstrainedWidth: screenWidth - (24 * 2) - imageSize - (10 + 24), font: UIFont(name: "Nunito-Bold", size: 18 + PublicFunction.dynamicSize()))
        let durasiHeight = "Durasi (jam)".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - imageSize - (10 + 24), font: UIFont(name: "Nunito-Regular", size: 10 + PublicFunction.dynamicSize()))
        let durasiValueHeight = "\(item.durasi)".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - imageSize - (10 + 24), font: UIFont(name: "SFProDisplay-Regular", size: 14 + PublicFunction.dynamicSize()))
        return CGSize(width: screenWidth - (24 * 2), height: 46 + titleHeight + hargaHeight + durasiHeight + durasiValueHeight)
    }
}

extension ParentTujuanWisataCell {
    @objc func buttonHapusClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        print("button hapus click \(indexPath.item)")
    }
    
    @objc func buttonMinClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        print("button min click \(indexPath.item)")
    }
    
    @objc func buttonPlusClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        print("button plus click \(indexPath.item)")
    }
    
    @objc func viewTambahTujuanWisataClick() {
        rencanaPerjalananVM.addTujuanWisata(tujuanWisata: TujuanWisataModel(id: rencanaPerjalananVM.listTujuanWisata.value.count + 1, name: "Candi Ijo", image: "https://4.bp.blogspot.com/-rXV48AAXKq4/VctwCBY4rKI/AAAAAAAAb-s/wLQCed7D18o/s1600/Candi%2BPrambanan.jpg", harga: "Rp 100.000", durasi: 1, hari: hari ?? 0))
    }
}
