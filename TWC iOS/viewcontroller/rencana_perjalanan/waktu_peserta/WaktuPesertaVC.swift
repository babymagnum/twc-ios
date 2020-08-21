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
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        observeData()
    }
    
    private func setupView() {
        imageCalendar.image = UIImage(named: "calendarToday")?.tinted(with: UIColor.veryLightPinkTwo)
    }
    
    private func observeData() {
        rencanaPerjalananVM.pesertaDewasa.subscribe(onNext: { value in
            self.labelDewasa.setTitle("\(value) dewasa", for: .normal)
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.pesertaAnak.subscribe(onNext: { value in
            self.labelAnak.setTitle("\(value) anak", for: .normal)
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.listTujuanWisata.subscribe(onNext: { value in
            var totalHarga = 0
            var tempat = ""
            
            value.forEach { item in
                item.listTicket.forEach { itemTiket in
                    totalHarga += itemTiket.harga * itemTiket.peserta
                }
                tempat += "\(item.name), "
            }
            
            self.labelHarga.text = PublicFunction.prettyRupiah("\(totalHarga)")
            self.labelTotalTempat.text = "\(value.count) tempat"
            self.labelTempat.text = "\(tempat.trim().dropLast())"
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.selectedDates.subscribe(onNext: { value in
            self.labelTanggalMulai.setTitle(PublicFunction.dateToString(value.first ?? Date(), "EEE, dd MMM yyyy"), for: .normal)
            self.labelTanggalSelesai.setTitle(PublicFunction.dateToString(value.last ?? Date(), "EEE, dd MMM yyyy"), for: .normal)
            self.labelHari.text = "\(value.count) hari"
        }).disposed(by: disposeBag)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Waktu Peserta")
    }
    
    @IBAction func selanjutnyaClick(_ sender: Any) {
        rencanaPerjalananVM.currentRencanaPerjalananPage.accept(2)
        rencanaPerjalananVM.maxRencanaPerjalananPage.accept(2)
    }
}
