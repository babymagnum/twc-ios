//
//  MetodePembayaranCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 14/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class MetodePembayaranCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: CustomLabel!
    
    var item: MetodePembayaranModel? {
        didSet {
            if let _item = item {
                image.image = UIImage(named: _item.image)
                label.text = _item.name
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
