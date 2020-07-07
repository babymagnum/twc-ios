//
//  DataPesertaCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class DataPesertaCell: UICollectionViewCell {

    @IBOutlet weak var labelNama: CustomLabel!
    @IBOutlet weak var labelTypePeserta: CustomLabel!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var labelNIK: CustomLabel!
    @IBOutlet weak var viewDivider: UIView!
    @IBOutlet weak var imageContactWidth: NSLayoutConstraint!
    @IBOutlet weak var imageContactMarginRight: NSLayoutConstraint!
    
    var item: DataPesertaModel? {
        didSet {
            if let _item = item {
                imageContactWidth.constant = _item.isKontak ? 18 : 0
                imageContactMarginRight.constant = _item.isKontak ? 6 : 0
                labelNama.text = _item.nama
                labelTypePeserta.text = _item.typePeserta
                labelPeserta.text = _item.peserta
                labelNIK.text = _item.nik
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    }

}
