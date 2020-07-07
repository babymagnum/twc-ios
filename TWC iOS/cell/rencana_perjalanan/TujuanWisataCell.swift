//
//  TujuanWisataCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class TujuanWisataCell: UICollectionViewCell {

    @IBOutlet weak var image: CustomImage!
    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var labelHarga: CustomLabel!
    @IBOutlet weak var labelDurasi: CustomLabel!
    @IBOutlet weak var buttonMin: CustomButton!
    @IBOutlet weak var buttonPlus: CustomButton!
    @IBOutlet weak var buttonHapus: CustomButton!
    
    var item: TujuanWisataModel? {
        didSet {
            if let _item = item {
                image.loadUrl(_item.image)
                labelNama.text = _item.name
                labelHarga.text = PublicFunction.prettyRupiah("\(_item.harga)")
                labelDurasi.text = "\(_item.durasi)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        image.roundCorners([.topLeft, .bottomRight], radius: 8)
        self.addShadow(CGSize(width: 1, height: 2), UIColor.black.withAlphaComponent(0.16), 3, 1)
    }

}
