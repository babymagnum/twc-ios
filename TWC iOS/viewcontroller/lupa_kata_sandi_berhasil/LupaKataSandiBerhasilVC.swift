//
//  LupaKataSandiBerhasilVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 28/06/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class LupaKataSandiBerhasilVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
        
        self.title = "Lupa kata sandi"
    }

    @IBAction func okClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
