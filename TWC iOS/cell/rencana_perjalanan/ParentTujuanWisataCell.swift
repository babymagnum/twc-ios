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
    var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    private var disposeBag = DisposeBag()
    private var listTujuanWisata = [PilihanTujuanWisataModel]()
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
            self.collectionTujuanWisata.layoutSubviews()
            
            UIView.animate(withDuration: 0.2) {
                self.collectionTujuanWisataMarginTop.constant = self.listTujuanWisata.count == 0 ? 0 : 10
                self.viewEmptyHeight.constant = self.listTujuanWisata.count == 0 ? 10000 : 0
                self.viewEmpty.isHidden = self.listTujuanWisata.count > 0
                self.collectionTujuanWisataHeight.constant = self.collectionTujuanWisata.contentSize.height
                self.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupCollection() {
        UIView.animate(withDuration: 0.2) {
            self.collectionTujuanWisataMarginTop.constant = 0
            self.collectionTujuanWisataHeight.constant = 0
            self.layoutIfNeeded()
        }
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
        cell.viewTambahkanPeserta.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTambahkanPesertaClick(sender:))))
//        cell.buttonHapus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonHapusClick(sender:))))
//        cell.buttonMin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonMinClick(sender:))))
//        cell.buttonPlus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonPlusClick(sender:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = screenWidth * 0.2
        let item = listTujuanWisata[indexPath.item]
        let titleHeight = item.name.getHeight(withConstrainedWidth: screenWidth - (24 * 2) - imageSize - (10 + 24), font: UIFont(name: "Nunito-Bold", size: 16 + PublicFunction.dynamicSize()))
        let tambahkanPesertaHeight = "Tambahkan peserta".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - (16 * 2), font: UIFont(name: "Nunito-Regular", size: 14 + PublicFunction.dynamicSize()))
        var collectionHeight: CGFloat = 0
        
        item.listTicket.forEach { value in
            if value.peserta > 0 {
                let hargaHeight = "\(value.harga)".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - (26) - imageSize - 10, font: UIFont(name: "Nunito-Bold", size: 18 + PublicFunction.dynamicSize()))
                let pesertaHeight = "Peserta".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - (26) - imageSize - 10, font: UIFont(name: "Nunito-Regular", size: 10 + PublicFunction.dynamicSize()))
                collectionHeight += hargaHeight + pesertaHeight + 37
            }
        }
        
        return CGSize(width: screenWidth - (24 * 2), height: collectionHeight + tambahkanPesertaHeight + titleHeight + 53)
    }
}

extension ParentTujuanWisataCell {
    @objc func viewTambahkanPesertaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        let vc = DetailTempatWisataVC()
        vc.selectedHari = hari
        vc.tujuanWisata = listTujuanWisata[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewTambahTujuanWisataClick() {
        let vc = PilihTujuanWisataVC()
        vc.selectedHari = hari ?? 1
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonHapusClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        guard let _vc = viewController else { return }
        
        PublicFunction.showUnderstandDialog(_vc, listTujuanWisata[indexPath.item].name, "Anda yakin ingin menghapus \(listTujuanWisata[indexPath.item].name) dari tujuan wisata?", "Hapus", "Cancel") {
            self.rencanaPerjalananVM.deleteTujuanWisata(tujuanWisata: self.listTujuanWisata[indexPath.item])
        }
    }
    
    @objc func buttonMinClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        let oldItem = listTujuanWisata[indexPath.item]
        
        if oldItem.durasi == 1 {
            self.makeToast("Minimal durasi adalah 1 jam")
        } else {
            var newItem = listTujuanWisata[indexPath.item]
            newItem.durasi -= 1
            
            rencanaPerjalananVM.updateTujuanWisata(oldTujuanWisata: oldItem, newTujuanWisata: newItem)
        }
    }
    
    @objc func buttonPlusClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTujuanWisata.indexPathForItem(at: sender.location(in: collectionTujuanWisata)) else { return }
        
        let oldItem = listTujuanWisata[indexPath.item]
        var newItem = listTujuanWisata[indexPath.item]
        newItem.durasi += 1
        
        rencanaPerjalananVM.updateTujuanWisata(oldTujuanWisata: oldItem, newTujuanWisata: newItem)
    }
}
