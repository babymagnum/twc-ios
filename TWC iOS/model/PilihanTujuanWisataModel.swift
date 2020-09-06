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
    var id: String
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

/// NETWORKING

struct ClusterModel: Decodable {
    var code: String
    var data = [ClusterData]()
    var success: Bool
    var message: String
}

struct ClusterData: Decodable {
    var cluster_id: Int?
    var cluster_mid: String?
    var cluster_name: String?
    var cluster_logo: String?
    var site = [SiteData]()
}

struct SiteData: Decodable {
    var site_id: Int?
    var site_mid: String?
    var site_name: String?
    var site_estimated: String?
    var site_logo: String?
}
