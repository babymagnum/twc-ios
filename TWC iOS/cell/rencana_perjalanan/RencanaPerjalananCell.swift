//
//  RencanaPerjalananCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class RencanaPerjalananCell: UICollectionViewCell {

    @IBOutlet weak var labelHari: CustomLabel!
    @IBOutlet weak var labelTanggal: CustomLabel!
    
    var item: RencanaPerjalananHariModel? {
        didSet {
            if let _item = item {
                labelHari.text = _item.nama
                labelTanggal.text = _item.tanggal
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
