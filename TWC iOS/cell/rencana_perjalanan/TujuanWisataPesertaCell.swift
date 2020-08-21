//
//  TujuanWisataPesertaCell.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 21/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class TujuanWisataPesertaCell: BaseCollectionViewCell {

    @IBOutlet weak var buttonMinus: CustomButton!
    @IBOutlet weak var buttonPlus: CustomButton!
    @IBOutlet weak var labelPeserta: CustomLabel!
    @IBOutlet weak var buttonHapus: CustomButton!
    @IBOutlet weak var labelNamaTiket: CustomLabel!
    @IBOutlet weak var labelHargaTiket: CustomLabel!
    
    var item: TiketItem? {
        didSet {
            if let _item = item {
                labelNamaTiket.text = _item.name
                labelHargaTiket.text = PublicFunction.prettyRupiah("\(_item.harga)")
                labelPeserta.text = "\(_item.peserta)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
