//
//  DialogBerhasilKirimDataAgen.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 18/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

protocol DialogBerhasilKirimDataAgenProtocol {
    func dismisClick(vc: UIViewController)
}

class DialogBerhasilKirimDataAgen: BaseViewController {

    var delegate: DialogBerhasilKirimDataAgenProtocol?
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: "check")?.tinted(with: UIColor.mediumGreen)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewParentClick)))
    }

    @objc func viewParentClick() {
        delegate?.dismisClick(vc: self)
    }
}
