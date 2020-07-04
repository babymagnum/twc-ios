//
//  TujuanWisataVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TujuanWisataVC: BaseViewController, IndicatorInfoProvider {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Tujuan Wisata")
    }

}
