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
    var listTujuanWisataCounter = BehaviorRelay(value: 0)
    var listTujuanWisata = BehaviorRelay(value: [TujuanWisataModel]())
    
    func addTujuanWisata(tujuanWisata: TujuanWisataModel) {
        var list = listTujuanWisata.value
        let counter = listTujuanWisataCounter.value
        list.append(tujuanWisata)
        listTujuanWisata.accept(list)
        listTujuanWisataCounter.accept(counter + 1)
    }
    
    func updateTujuanWisata(oldTujuanWisata: TujuanWisataModel, newTujuanWisata: TujuanWisataModel) {
        var list = listTujuanWisata.value
        let selectedIndex = list.firstIndex { item -> Bool in
            return item.id == oldTujuanWisata.id
        } ?? 0
        list[selectedIndex] = newTujuanWisata
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
