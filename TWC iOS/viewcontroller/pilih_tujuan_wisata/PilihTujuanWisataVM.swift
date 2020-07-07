//
//  PilihTujuanWisataVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class PilihTujuanWisataVM: BaseViewModel {
    var listYogyakarta = BehaviorRelay(value: [PilihanTujuanWisataModel]())
    var listMagelang = BehaviorRelay(value: [PilihanTujuanWisataModel]())
    var listDieng = BehaviorRelay(value: [PilihanTujuanWisataModel]())
    
    func getTujuanWisata() {
        let _listYogyakarta = [
            PilihanTujuanWisataModel(nama: "Candi Ratu Boko", durasi: 2, harga: 100000, image: "https://www.nativeindonesia.com/wp-content/uploads/2018/08/keraton-ratu-boko-sunset.jpg"),
            PilihanTujuanWisataModel(nama: "Candi Prambanan", durasi: 2, harga: 100000, image: "https://4.bp.blogspot.com/-XxXXKldrLjA/V7ur8gNuQmI/AAAAAAAAADE/58Q9S8GAg94S_EO0l1FLKqZ8TcSWpaoEgCLcB/s1600/candi%2Bpramb.jpg")
        ]
        
        let _listMagelang = [
            PilihanTujuanWisataModel(nama: "Candi Borobudur", durasi: 2, harga: 100000, image: "https://cdn2.tstatic.net/palu/foto/bank/images/stupa-di-candi-borobudur.jpg"),
            PilihanTujuanWisataModel(nama: "Candi Mendut", durasi: 2, harga: 100000, image: "https://www.pegipegi.com/travel/wp-content/uploads/2015/06/Candi-Mendut.png")
        ]
        
        let _listDieng = [
            PilihanTujuanWisataModel(nama: "Candi Arjuna", durasi: 2, harga: 100000, image: "https://cdn2.tstatic.net/tribunnewswiki/foto/bank/images/candi-arjuna2.jpg"),
            PilihanTujuanWisataModel(nama: "Candi Bima", durasi: 2, harga: 100000, image: "https://visitjawatengah.jatengprov.go.id/assets/images/741a62d7-68bb-41f1-8bba-636358e102ba.jpg")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.listYogyakarta.accept(_listYogyakarta)
            self.listMagelang.accept(_listMagelang)
            self.listDieng.accept(_listDieng)
        }
    }
}
