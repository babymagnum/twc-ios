//
//  PaketFavoritCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 01/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class PaketFavoritCell: BaseCollectionViewCell, UICollectionViewDelegate {

    @IBOutlet weak var labelJumlahTempat: CustomLabel!
    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var labelName: CustomLabel!
    @IBOutlet weak var collectionImage: UICollectionView!
    @IBOutlet weak var collectionImageHeight: NSLayoutConstraint!
    @IBOutlet weak var labelHari: CustomLabel!
    @IBOutlet weak var labelOriginPrice: CustomLabel!
    @IBOutlet weak var labelDiscountPrice: CustomLabel!
    
    private var listImage = [String]()
    
    var item: PaketFavoriteModel? {
        didSet {
            if let _item = item {
                labelJumlahTempat.text = _item.jumlahTempat
                labelName.text = _item.name
                labelHari.text = _item.hari
                labelDiscountPrice.text = _item.discountPrice
                listImage = _item.images
                collectionImage.reloadData()
                
                let attrString = NSAttributedString(string: _item.originPrice ?? "", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
                labelOriginPrice.attributedText = attrString
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.collectionImageHeight.constant = self.collectionImage.contentSize.height
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollection()
        
        self.addShadow(CGSize(width: 1, height: 2), UIColor.black.withAlphaComponent(0.16), 3, 1)
    }

    private func setupCollection() {
        collectionImage.delegate = self
        collectionImage.dataSource = self
        collectionImage.register(UINib(nibName: "PaketFavoriteImageCell", bundle: .main), forCellWithReuseIdentifier: "PaketFavoriteImageCell")
    }
}

extension PaketFavoritCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PaketFavoriteImageCell", for: indexPath) as! PaketFavoriteImageCell
        cell.image.loadUrl(listImage[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth * 0.067, height: screenWidth * 0.067)
    }
}
