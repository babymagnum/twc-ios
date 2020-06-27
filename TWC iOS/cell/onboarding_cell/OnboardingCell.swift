//
//  OnboardingCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 27/06/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var labelTitle: CustomLabel!
    @IBOutlet weak var labelDescription: CustomLabel!
    
    var item: OnboardingItem? {
        didSet {
            if let _item = item {
                image.image = UIImage(named: _item.image)
                labelTitle.text = _item.title
                labelDescription.text = _item.description
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
