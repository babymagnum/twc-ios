//
//  HariCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class HariCell: UICollectionViewCell {

    @IBOutlet weak var imageCalendar: UIImageView!
    @IBOutlet weak var labelHari: CustomLabel!
    @IBOutlet weak var viewParent: UIView!
    
    var item: HariModel? {
        didSet {
            if let _item = item {
                labelHari.text = _item.name
                labelHari.textColor = _item.selected ? UIColor.charcoalGrey : UIColor.veryLightPinkTwo
                imageCalendar.image = UIImage(named: "calendarToday")?.tinted(with: _item.selected ? UIColor.charcoalGrey : UIColor.veryLightPinkTwo)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
