//
//  RencanaPerjalananVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 05/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class RencanaPerjalananVM: BaseViewModel {
    var listTujuanWisata = BehaviorRelay(value: [TujuanWisataModel]())
    
    func addTujuanWisata(tujuanWisata: TujuanWisataModel) {
        var list = listTujuanWisata.value
        list.append(tujuanWisata)
        listTujuanWisata.accept(list)
    }
    
    func deleteTujuanWisata(tujuanWisata: TujuanWisataModel) {
        var list = listTujuanWisata.value
        list.removeAll { item -> Bool in
            return item.id == tujuanWisata.id
        }
        listTujuanWisata.accept(list)
    }
}
