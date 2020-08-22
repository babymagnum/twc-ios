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
    var listTujuanWisata = BehaviorRelay(value: [PilihanTujuanWisataModel]())
    var listRencanaPerjalanan = BehaviorRelay(value: [Any]())
    var listDataPeserta = BehaviorRelay(value: [DataPesertaModel]())
    var pesertaDewasa = BehaviorRelay(value: 0)
    var pesertaAnak = BehaviorRelay(value: 0)
    var selectedDates = BehaviorRelay(value: [Date()])
    var currentRencanaPerjalananPage = BehaviorRelay(value: 0)
    var maxRencanaPerjalananPage = BehaviorRelay(value: 0)
    var dataKontakPerson = BehaviorRelay(value: DataKontakPerson())
    
    func resetAllData() {
        listTujuanWisata.accept([PilihanTujuanWisataModel]())
        listRencanaPerjalanan.accept([Any]())
        listDataPeserta.accept([DataPesertaModel]())
        pesertaDewasa.accept(0)
        pesertaAnak.accept(0)
        selectedDates.accept([Date()])
        currentRencanaPerjalananPage.accept(0)
        maxRencanaPerjalananPage.accept(0)
        dataKontakPerson.accept(DataKontakPerson())
    }
    
    func updateDataPeserta(selectedIndex: Int, newData: DataPesertaModel) {
        var _listPeserta = listDataPeserta.value
        _listPeserta[selectedIndex] = newData
        
        for (index, _) in _listPeserta.enumerated() {
            if index != selectedIndex {
                _listPeserta[index].isKontak = false
            }
        }
        
        listDataPeserta.accept(_listPeserta)
    }
    
    func addTujuanWisata(tujuanWisata: PilihanTujuanWisataModel) {
        var list = listTujuanWisata.value
        list.append(tujuanWisata)
        listTujuanWisata.accept(list)
    }
    
    func updateTujuanWisata(oldTujuanWisata: PilihanTujuanWisataModel, newTujuanWisata: PilihanTujuanWisataModel) {
        var list = listTujuanWisata.value
        let selectedIndex = list.firstIndex { item -> Bool in
            return item.id == oldTujuanWisata.id
        } ?? 0
        list[selectedIndex] = newTujuanWisata
        listTujuanWisata.accept(list)
    }
    
    func deleteTujuanWisata(tujuanWisata: PilihanTujuanWisataModel) {
        var list = listTujuanWisata.value
        list.removeAll { item -> Bool in
            return item.id == tujuanWisata.id
        }
        listTujuanWisata.accept(list)
    }
    
    func generateDataPeserta() {
        var _listDataPeserta = [DataPesertaModel]()
        
        for index in 0...pesertaDewasa.value - 1 {
            _listDataPeserta.append(DataPesertaModel(nama: "Dewasa \(index + 1)", peserta: "Dewasa \(index + 1)", title: "", nomorIdentitas: "", isKontak: false, tipeIdentitas: "Tipe identitas", isFilled: false))
        }
        
        if pesertaAnak.value > 0 {
            for index in 0...pesertaAnak.value - 1 {
                _listDataPeserta.append(DataPesertaModel(nama: "Anak \(index + 1)", peserta: "Anak \(index + 1)", title: "", nomorIdentitas: "", isKontak: false, tipeIdentitas: "Tipe identitas", isFilled: false))
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
            } else {
                let itemBefore = list[index - 1]
                
                firstDate = Calendar.current.date(byAdding: .day, value: 1, to: firstDate) ?? Date()
                
                if item.hari > itemBefore.hari {
                    _listRencanaPerjalanan.append(RencanaPerjalananHariModel(nama: "Hari \(item.hari)", tanggal: PublicFunction.dateToString(firstDate, "dd MMMM yyyy")))
                }
            }
            
            item.listTicket.forEach { tiketItem in
                if tiketItem.peserta > 0 {
                    _listRencanaPerjalanan.append(RencanaPerjalananTempatModel(nama: "\(item.name) X\(tiketItem.peserta)", typePeserta: tiketItem.name, peserta: tiketItem.peserta, harga: tiketItem.harga))
                }
            }
        }
        
        listRencanaPerjalanan.accept(_listRencanaPerjalanan)
    }
}
