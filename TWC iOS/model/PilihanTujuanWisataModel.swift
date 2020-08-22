//
//  PilihanTujuanWisataModel.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation

struct PilihanTujuanWisataModel {
    var originId: String
    var id: Int
    var hari: Int
    var name: String
    var durasi: Int
    var image: String
    var listTicket = [TiketItem]()
}

struct TiketItem {
    var id: Int
    var name: String
    var harga: Int
    var peserta: Int
}
