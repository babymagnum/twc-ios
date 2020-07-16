//
//  DetailMetodePembayaranVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 16/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class DetailMetodePembayaranVM: BaseViewModel {
    var listStep = BehaviorRelay(value: [BankTransfer]())
    
    func generateStep() {
        var _listStep = [BankTransfer]()
        
        _listStep.append(BankTransfer(number: 1, content: "Masukkan kartu ATM BCA"))
        _listStep.append(BankTransfer(number: 2, content: "Masukkan PIN ATM BCA Anda"))
        _listStep.append(BankTransfer(number: 3, content: "Pilih menu \"TRANSAKSI LAINNYA\""))
        _listStep.append(BankTransfer(number: 4, content: "Pilih menu \"TRANSFER\""))
        _listStep.append(BankTransfer(number: 5, content: "Pilih menu \"KE REK. BCA VIRTUAL ACCOUNT\""))
        _listStep.append(BankTransfer(number: 6, content: "Masukkan nomor Virtual Account"))
        _listStep.append(BankTransfer(number: 7, content: "Pastikan data Virtual Account Anda benar, kemudian masukkan angka yang perlu Anda bayarkan, kemudian pilih \"BENAR\""))
        _listStep.append(BankTransfer(number: 8, content: "Cek & Perhatikan Konfirmasi Pembayaran dari layar ATM, jika sudah benar pilih \"YA\", atau pilih \"TIDAK\" jika data di layar masih salah"))
        _listStep.append(BankTransfer(number: 9, content: "Transaksi Anda sudah selesai, pilih \"TIDAK\" untuk tidak melanjutkan transaksi lain"))
        
        listStep.accept(_listStep)
    }
}
