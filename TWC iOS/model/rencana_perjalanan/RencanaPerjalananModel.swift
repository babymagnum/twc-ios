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

struct TujuanWisataModel {
    var id: Int
    var name: String
    var image: String
    var harga: Int
    var durasi: Int
    var hari: Int
}

struct RencanaPerjalananHariModel {
    var nama: String
    var tanggal: String
}

struct RencanaPerjalananTempatModel {
    var nama: String
    var durasi: Int
    var harga: Int
}

struct DataPesertaModel {
    var nama: String
    var peserta: String
    var typePeserta: String
    var nik: String
    var isKontak: Bool
}
