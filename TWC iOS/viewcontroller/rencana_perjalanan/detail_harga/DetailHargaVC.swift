//
//  DetailHargaVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 16/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class DetailHargaVC: BaseViewController {

    @IBOutlet weak var labelTiketWisata: CustomLabel!
    @IBOutlet weak var labelTotalPeserta: CustomLabel!
    @IBOutlet weak var labelDiskon: CustomLabel!
    @IBOutlet weak var labelTotalBayar: CustomLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        self.title = "Detail harga"
        navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
    }
}
