//
//  PilihTujuanWisataCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class PilihTujuanWisataCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var buttonAdd: UIButton!
    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var labelDurasi: CustomButton!
    
    var item: PilihanTujuanWisataModel? {
        didSet {
            if let _item = item {
                image.loadUrl(_item.image)
                labelNama.text = _item.name
                labelDurasi.setTitle("Estimasi: \(_item.durasi) jam", for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addShadow(CGSize(width: 1, height: 2), UIColor.black.withAlphaComponent(0.16), 3, 1)
    }

}
