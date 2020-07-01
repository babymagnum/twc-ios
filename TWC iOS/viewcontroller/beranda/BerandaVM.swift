//
//  BerandaVM.swift
//  Eoviz Presence
//
//  Created by Arief Zainuri on 13/04/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxRelay

class BerandaVM: BaseViewModel {
    var loadingPaketFavorit = BehaviorRelay(value: false)
    var listPaketFavorite = BehaviorRelay(value: [PaketFavoriteModel]())
    
    func getPaketFavorite() {
        loadingPaketFavorit.accept(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let list = [
                PaketFavoriteModel(jumlahTempat: "3 tempat", name: "Prambanan, Ratu Boko, Merapi", images: [
                    "https://4.bp.blogspot.com/-rXV48AAXKq4/VctwCBY4rKI/AAAAAAAAb-s/wLQCed7D18o/s1600/Candi%2BPrambanan.jpg",
                    "https://4.bp.blogspot.com/-rXV48AAXKq4/VctwCBY4rKI/AAAAAAAAb-s/wLQCed7D18o/s1600/Candi%2BPrambanan.jpg"
                ], hari: "2 hari", originPrice: "Rp 320.000", discountPrice: "Rp 300.000"),
                PaketFavoriteModel(jumlahTempat: "3 tempat", name: "Prambanan, Ratu Boko, Merapi", images: [
                    "https://4.bp.blogspot.com/-rXV48AAXKq4/VctwCBY4rKI/AAAAAAAAb-s/wLQCed7D18o/s1600/Candi%2BPrambanan.jpg",
                    "https://4.bp.blogspot.com/-rXV48AAXKq4/VctwCBY4rKI/AAAAAAAAb-s/wLQCed7D18o/s1600/Candi%2BPrambanan.jpg"
                ], hari: "2 hari", originPrice: "Rp 320.000", discountPrice: "Rp 300.000")
            ]
            
            self.listPaketFavorite.accept(list)
            self.loadingPaketFavorit.accept(false)
        }
    }
}
