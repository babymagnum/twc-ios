//
//  DetailTempatTiketCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 19/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class DetailTempatTiketCell: BaseCollectionViewCell {

    @IBOutlet weak var labelType: CustomLabel!
    @IBOutlet weak var labelHarga: CustomLabel!
    @IBOutlet weak var viewTambah: CustomView!
    @IBOutlet weak var viewPlusMinus: UIView!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var buttonMinus: CustomButton!
    @IBOutlet weak var buttonPlus: CustomButton!
    
    var item: TiketItem? {
        didSet {
            if let _item = item {
                labelType.text = _item.name
                labelHarga.text = PublicFunction.prettyRupiah("\(_item.harga)")
                labelPeserta.text = "\(_item.peserta)"
                viewTambah.isHidden = _item.peserta > 0
                viewPlusMinus.isHidden = _item.peserta == 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
