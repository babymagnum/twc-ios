//
//  RencanaPerjalananHariTempat.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation

struct HariModel {
    var name: String
    var selected: Bool
}

struct RencanaPerjalananHariModel {
    var nama: String
    var tanggal: String
}

struct RencanaPerjalananTempatModel {
    var nama: String
    var typePeserta: String
    var peserta: Int
    var harga: Int
}

struct DataPesertaModel {
    var nama: String
    var peserta: String
    var title: String
    var nomorIdentitas: String
    var isKontak: Bool
    var tipeIdentitas: String
    var isFilled: Bool
}

struct DataKontakPerson {
    var nomorHandphone: String?
    var email: String?
    var alamat: String?
}
