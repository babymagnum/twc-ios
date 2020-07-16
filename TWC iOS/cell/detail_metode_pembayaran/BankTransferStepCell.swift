//
//  BankTransferStepCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 16/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class BankTransferStepCell: UICollectionViewCell {

    @IBOutlet weak var labelNumber: CustomLabel!
    @IBOutlet weak var labelContent: CustomLabel!
    
    var item: BankTransfer? {
        didSet {
            if let _item = item {
                labelNumber.text = "\(_item.number)"
                labelContent.text = _item.content
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
