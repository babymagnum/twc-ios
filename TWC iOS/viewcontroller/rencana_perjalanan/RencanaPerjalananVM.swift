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
    var listRencanaPerjalanan = BehaviorRelay(value: [Any]())
    var listDataPeserta = BehaviorRelay(value: [DataPesertaModel]())
    var pesertaDewasa = BehaviorRelay(value: 0)
    var pesertaAnak = BehaviorRelay(value: 0)
    var selectedDates = BehaviorRelay(value: [Date()])
    var currentRencanaPerjalananPage = BehaviorRelay(value: 0)
    var maxRencanaPerjalananPage = BehaviorRelay(value: 0)
    
    func resetAllData() {
        listTujuanWisataCounter.accept(0)
        listTujuanWisata.accept([TujuanWisataModel]())
        listRencanaPerjalanan.accept([Any]())
        listDataPeserta.accept([DataPesertaModel]())
        pesertaDewasa.accept(0)
        pesertaAnak.accept(0)
        selectedDates.accept([Date()])
        currentRencanaPerjalananPage.accept(0)
        maxRencanaPerjalananPage.accept(0)
    }
    
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
    
    func generateDataPeserta() {
        var _listDataPeserta = [DataPesertaModel]()
        
        for index in 0...pesertaDewasa.value - 1 {
            _listDataPeserta.append(DataPesertaModel(nama: "Dewasa \(index + 1)", peserta: "Lengkapi data peserta", typePeserta: "", nik: "", isKontak: false))
        }
        
        if pesertaAnak.value > 0 {
            for index in 0...pesertaAnak.value - 1 {
                _listDataPeserta.append(DataPesertaModel(nama: "Anak \(index + 1)", peserta: "Lengkapi data peserta", typePeserta: "", nik: "", isKontak: false))
            }
        }
        
        listDataPeserta.accept(_listDataPeserta)
    }
    
    func generateRencanaPerjalanan() {
        var list = listTujuanWisata.value
        var _listRencanaPerjalanan = [Any]()
        
        list.sort { (item1, item2) -> Bool in
            return item1.hari < item2.hari
        }
        
        var firstDate = selectedDates.value.first ?? Date()
        
        for (index, item) in list.enumerated() {
            if index == 0 {
                _listRencanaPerjalanan.append(RencanaPerjalananHariModel(nama: "Hari \(item.hari)", tanggal: PublicFunction.dateToString(firstDate, "dd MMMM yyyy")))
                _listRencanaPerjalanan.append(RencanaPerjalananTempatModel(nama: item.name, durasi: item.durasi, harga: item.harga))
            } else {
                let itemBefore = list[index - 1]
                
                firstDate = Calendar.current.date(byAdding: .day, value: 1, to: firstDate) ?? Date()
                
                if item.hari > itemBefore.hari {
                    _listRencanaPerjalanan.append(RencanaPerjalananHariModel(nama: "Hari \(item.hari)", tanggal: PublicFunction.dateToString(firstDate, "dd MMMM yyyy")))
                    _listRencanaPerjalanan.append(RencanaPerjalananTempatModel(nama: item.name, durasi: item.durasi, harga: item.harga))
                } else {
                    _listRencanaPerjalanan.append(RencanaPerjalananTempatModel(nama: item.name, durasi: item.durasi, harga: item.harga))
                }
            }
        }
        
        listRencanaPerjalanan.accept(_listRencanaPerjalanan)
    }
}
