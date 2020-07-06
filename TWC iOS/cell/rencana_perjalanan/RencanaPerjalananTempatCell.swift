//
//  RencanaPerjalananTempatCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class RencanaPerjalananTempatCell: UICollectionViewCell {

    @IBOutlet weak var viewLineTop: UIView!
    @IBOutlet weak var viewLineBot: UIView!
    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var labelDurasi: CustomLabel!
    @IBOutlet weak var labelHarga: CustomLabel!
    @IBOutlet weak var viewDivider: UIView!
    
    var item: RencanaPerjalananTempatModel? {
        didSet {
            if let _item = item {
                labelNama.text = _item.nama
                labelDurasi.text = "Durasi \(_item.durasi) jam"
                labelHarga.text = _item.harga
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
