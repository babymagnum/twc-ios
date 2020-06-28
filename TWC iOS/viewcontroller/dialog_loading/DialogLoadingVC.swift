//
//  DialogLoadingVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 28/06/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

protocol DialogLoadingProtocol {
    func loading(vc: UIViewController?)
}

class DialogLoadingVC: UIViewController {

    var delegate: DialogLoadingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate?.loading(vc: self)
    }

}
