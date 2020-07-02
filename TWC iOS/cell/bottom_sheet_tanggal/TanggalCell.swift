//
//  TanggalCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 02/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import JTAppleCalendar

class TanggalCell: JTACDayCell {

    @IBOutlet weak var marginTopViewParent: NSLayoutConstraint!
    @IBOutlet weak var marginRightViewParent: NSLayoutConstraint!
    @IBOutlet weak var marginLeftViewParent: NSLayoutConstraint!
    @IBOutlet weak var labelTanggal: CustomLabel!
    @IBOutlet weak var viewParent: CustomView!
    @IBOutlet weak var marginBottomViewParent: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
