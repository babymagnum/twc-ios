//
//  TujuanWisataCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class TujuanWisataCell: BaseCollectionViewCell, UICollectionViewDelegate {

    @IBOutlet weak var image: CustomImage!
    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var collectionPeserta: UICollectionView!
    @IBOutlet weak var collectionPesertaHeight: NSLayoutConstraint!
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var collectionPesertaMarginBottom: NSLayoutConstraint!
    @IBOutlet weak var viewTambahkanPeserta: CustomView!
    
    var listPeserta = [TiketItem]()
    
    var item: PilihanTujuanWisataModel? {
        didSet {
            if let _item = item {
                image.loadUrl(_item.image)
                labelNama.text = _item.name
                listPeserta.removeAll()
                _item.listTicket.forEach { itemTiket in
                    if itemTiket.peserta > 0 {
                        listPeserta.append(itemTiket)
                    }
                }
                
                collectionPesertaMarginBottom.constant = listPeserta.count > 0 ? 29.5 : 10
                collectionPeserta.reloadData()
                collectionPeserta.layoutSubviews()
                
                UIView.animate(withDuration: 0.2) {
                    self.collectionPesertaHeight.constant = self.collectionPeserta.contentSize.height
                    self.layoutIfNeeded()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionPesertaHeight.constant = 0
        self.layoutIfNeeded()
        imageAdd.image = UIImage(named: "add24Px2")?.tinted(with: UIColor.mediumGreen)
        setupCollection()
        image.roundCorners([.topLeft, .bottomRight], radius: 8)
        self.addShadow(CGSize(width: 1, height: 2), UIColor.black.withAlphaComponent(0.16), 3, 1)
    }

    private func setupCollection() {
        collectionPeserta.register(UINib(nibName: "TujuanWisataPesertaCell", bundle: .main), forCellWithReuseIdentifier: "TujuanWisataPesertaCell")
        collectionPeserta.delegate = self
        collectionPeserta.dataSource = self
    }
}

extension TujuanWisataCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listPeserta.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TujuanWisataPesertaCell", for: indexPath) as! TujuanWisataPesertaCell
        cell.item = listPeserta[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = listPeserta[indexPath.item]
        let imageSize = screenWidth * 0.2
        let hargaHeight = "\(item.harga)".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - (26) - imageSize - 10, font: UIFont(name: "Nunito-Bold", size: 18 + PublicFunction.dynamicSize()))
        let pesertaHeight = "Peserta".getHeight(withConstrainedWidth: screenWidth - (24 * 2) - (26) - imageSize - 10, font: UIFont(name: "Nunito-Regular", size: 10 + PublicFunction.dynamicSize()))
        return CGSize(width: screenWidth - (24 * 2) - (26) - imageSize - 10, height: hargaHeight + pesertaHeight + 18 + 10 + 1 + 16)
    }
}
