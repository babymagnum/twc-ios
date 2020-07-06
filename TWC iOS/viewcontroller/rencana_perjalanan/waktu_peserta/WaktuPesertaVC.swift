//
//  WaktuPesertaVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import RxSwift
import DIKit

class WaktuPesertaVC: BaseViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var labelTotalTempat: CustomLabel!
    @IBOutlet weak var labelTempat: CustomLabel!
    @IBOutlet weak var labelHari: CustomLabel!
    @IBOutlet weak var imageCalendar: UIImageView!
    @IBOutlet weak var labelHarga: CustomLabel!
    @IBOutlet weak var labelTanggalMulai: CustomButton!
    @IBOutlet weak var labelTanggalSelesai: CustomButton!
    @IBOutlet weak var labelDewasa: CustomButton!
    @IBOutlet weak var labelAnak: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Waktu Peserta")
    }
    
    @IBAction func selanjutnyaClick(_ sender: Any) {
    }
}
