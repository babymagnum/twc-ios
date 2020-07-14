//
//  PembayaranVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 14/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class PembayaranVM: BaseViewModel {
    
    var listInternetBanking = BehaviorRelay(value: [MetodePembayaranModel]())
    var listATMTransfer = BehaviorRelay(value: [MetodePembayaranModel]())
    var listEmoney = BehaviorRelay(value: [MetodePembayaranModel]())
    var listLainya = BehaviorRelay(value: [MetodePembayaranModel]())
    var time = BehaviorRelay(value: "02:00")
    
    private var seconds = 0
    private var minutes = 0
    private var timer: Timer?
    
    func startTimer() {
        if let _timer = timer {
            _timer.invalidate()
        }
        
        let timeArray = "2:1".components(separatedBy: ":")
        
        minutes = Int(timeArray[0])!
        seconds = Int(timeArray[1])!
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.seconds -= 1
            
            let time = "\(String(self.minutes).count == 1 ? "0\(self.minutes)" : "\(String(self.minutes))"):\(String(self.seconds).count == 1 ? "0\(self.seconds)" : "\(String(self.seconds))")"
            
            self.time.accept(time)
            
            if self.minutes >= 1 && self.seconds == 0 {
                self.minutes -= 1
                self.seconds = 60
            }
            
            if self.minutes == 0 && self.seconds == 0 {
                timer.invalidate()
                self.minutes = 0
                self.seconds = 0
                
                let time = "\(String(self.minutes).count == 1 ? "0\(self.minutes)" : "\(String(self.minutes))"):\(String(self.seconds).count == 1 ? "0\(self.seconds)" : "\(String(self.seconds))")"
                
                self.time.accept(time)
            }
        }
    }
    
    func generateMetodePembayaran() {
        let _listIB = [
            MetodePembayaranModel(image: "bca", name: "BCA"),
            MetodePembayaranModel(image: "bri", name: "BRI"),
            MetodePembayaranModel(image: "bni", name: "BNI"),
            MetodePembayaranModel(image: "mandiri", name: "Mandiri")
        ]
        
        let _listATM = [
            MetodePembayaranModel(image: "bca", name: "BCA"),
            MetodePembayaranModel(image: "bri", name: "BRI"),
            MetodePembayaranModel(image: "bni", name: "BNI"),
            MetodePembayaranModel(image: "mandiri", name: "Mandiri")
        ]
        
        let _listEmoney = [
            MetodePembayaranModel(image: "ovo", name: "OVO"),
            MetodePembayaranModel(image: "linkaja", name: "LinkAja"),
            MetodePembayaranModel(image: "paytren", name: "Paytren")
        ]
        
        let _listLainya = [
            MetodePembayaranModel(image: "alfamart", name: "Alfamart"),
            MetodePembayaranModel(image: "indomaret", name: "Indomaret")
        ]
        
        listInternetBanking.accept(_listIB)
        listATMTransfer.accept(_listATM)
        listEmoney.accept(_listEmoney)
        listLainya.accept(_listLainya)
    }
    
}
