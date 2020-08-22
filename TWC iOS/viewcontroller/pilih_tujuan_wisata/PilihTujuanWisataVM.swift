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
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Ratu Boko", durasi: 2, image: "https://www.nativeindonesia.com/wp-content/uploads/2018/08/keraton-ratu-boko-sunset.jpg", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ]),
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Prambanan", durasi: 2, image: "https://4.bp.blogspot.com/-XxXXKldrLjA/V7ur8gNuQmI/AAAAAAAAADE/58Q9S8GAg94S_EO0l1FLKqZ8TcSWpaoEgCLcB/s1600/candi%2Bpramb.jpg", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ])
        ]
        
        let _listMagelang = [
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Borobudur", durasi: 2, image: "https://cdn2.tstatic.net/palu/foto/bank/images/stupa-di-candi-borobudur.jpg", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ]),
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Mendut", durasi: 2, image: "https://www.pegipegi.com/travel/wp-content/uploads/2015/06/Candi-Mendut.png", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ])
        ]
        
        let _listDieng = [
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Arjuna", durasi: 2, image: "https://cdn2.tstatic.net/tribunnewswiki/foto/bank/images/candi-arjuna2.jpg", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ]),
            PilihanTujuanWisataModel(originId: UUID().uuidString, id: "", hari: 0, name: "Candi Bima", durasi: 2, image: "https://visitjawatengah.jatengprov.go.id/assets/images/741a62d7-68bb-41f1-8bba-636358e102ba.jpg", listTicket: [
                TiketItem(id: 1, name: "Domestik dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 2, name: "Domestik anak-anak", harga: 30000, peserta: 0),
                TiketItem(id: 3, name: "Wisman dewasa", harga: 40000, peserta: 0),
                TiketItem(id: 4, name: "Wisman anak-anak", harga: 30000, peserta: 0)
            ])
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.listYogyakarta.accept(_listYogyakarta)
            self.listMagelang.accept(_listMagelang)
            self.listDieng.accept(_listDieng)
        }
    }
}
