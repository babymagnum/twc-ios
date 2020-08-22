//
//  DetailTempatWisataVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 19/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import DIKit

class DetailTempatWisataVC: BaseViewController, UICollectionViewDelegate {

    @IBOutlet weak var imageTempat: UIImageView!
    @IBOutlet weak var buttonEstimasi: CustomButton!
    @IBOutlet weak var collectionTiket: UICollectionView!
    @IBOutlet weak var collectionTiketHeight: NSLayoutConstraint!
    @IBOutlet weak var labelDeskripsi: CustomLabel!
    
    var tujuanWisata: PilihanTujuanWisataModel?
    var selectedHari: Int?
    var fromTujuanWisata: Bool?
    
    private var newTujuanWisata: PilihanTujuanWisataModel!
    private var hasAddNewTujuanWisata = false
    private var listTicket = [TiketItem]()
    private var disposeBag = DisposeBag()
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupCollection()
    }
    
    private func setupView() {
        if let _tujuanWisata = tujuanWisata {
            newTujuanWisata = _tujuanWisata
            imageTempat.loadUrl(_tujuanWisata.image)
            buttonEstimasi.setTitle("Estimasi: \(_tujuanWisata.durasi) jam", for: .normal)
            self.title = _tujuanWisata.name
            listTicket = _tujuanWisata.listTicket
            hasAddNewTujuanWisata = listTicket.contains { item -> Bool in item.peserta > 0 } || fromTujuanWisata ?? false
        }
    }
    
    private func setupCollection() {
        collectionTiket.delegate = self
        collectionTiket.dataSource = self
        collectionTiket.register(UINib(nibName: "DetailTempatTiketCell", bundle: .main), forCellWithReuseIdentifier: "DetailTempatTiketCell")
        
        collectionTiket.reloadData()
        collectionTiket.layoutSubviews()
        
        UIView.animate(withDuration: 0.2) {
            self.collectionTiketHeight.constant = self.collectionTiket.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
}

extension DetailTempatWisataVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @objc func plusPesertaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTiket.indexPathForItem(at: sender.location(in: collectionTiket)) else { return }
        
        listTicket[indexPath.item].peserta += 1
        collectionTiket.reloadData()
        collectionTiket.layoutSubviews()
        
        addOrUpdateTujuanWisata()
    }
    
    @objc func minusPesertaClick(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionTiket.indexPathForItem(at: sender.location(in: collectionTiket)) else { return }
        
        listTicket[indexPath.item].peserta -= 1
        collectionTiket.reloadData()
        collectionTiket.layoutSubviews()
        
        addOrUpdateTujuanWisata()
    }
    
    @objc func viewTambahTiketClick(sender: UITapGestureRecognizer) {
        
        guard let indexPath = collectionTiket.indexPathForItem(at: sender.location(in: collectionTiket)) else { return }
        
        listTicket[indexPath.item].peserta = 1
        collectionTiket.reloadData()
        collectionTiket.layoutSubviews()
        
        addOrUpdateTujuanWisata()
    }
    
    private func addOrUpdateTujuanWisata() {
        if !hasAddNewTujuanWisata {
            newTujuanWisata.id = rencanaPerjalananVM.listTujuanWisataCounter.value
        }
        
        let oldTujuanWisata = newTujuanWisata
        
        newTujuanWisata.hari = selectedHari ?? 0
        newTujuanWisata.listTicket = listTicket
        
        guard let _oldTW = oldTujuanWisata, let _newTW = newTujuanWisata else { return }
        
        if rencanaPerjalananVM.listTujuanWisata.value.contains(where: { item -> Bool in
            item.id == newTujuanWisata.id
        }) {
            hasAddNewTujuanWisata = true
            self.rencanaPerjalananVM.updateTujuanWisata(oldTujuanWisata: _oldTW, newTujuanWisata: _newTW)
        } else {
            hasAddNewTujuanWisata = true
            self.rencanaPerjalananVM.addTujuanWisata(tujuanWisata: _newTW)
        }
        
        if rencanaPerjalananVM.listTujuanWisata.value.contains(where: { item -> Bool in
            !item.listTicket.contains { itemTicket -> Bool in
                itemTicket.peserta > 0
            }
        }) {
            self.rencanaPerjalananVM.deleteTujuanWisata(tujuanWisata: _newTW)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listTicket.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailTempatTiketCell", for: indexPath) as! DetailTempatTiketCell
        cell.item = listTicket[indexPath.item]
        cell.viewTambah.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTambahTiketClick(sender:))))
        cell.buttonPlus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(plusPesertaClick(sender:))))
        cell.buttonMinus.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(minusPesertaClick(sender:))))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = listTicket[indexPath.item]
        let namaHeight = item.name.getHeight(withConstrainedWidth: screenWidth - 32, font: UIFont(name: "SFProDisplay-Regular", size: 14 + PublicFunction.dynamicSize()))
        let hargaHeight = "\(item.harga)".getHeight(withConstrainedWidth: screenWidth - 32, font: UIFont(name: "SFProDisplay-Bold", size: 14 + PublicFunction.dynamicSize()))
        return CGSize(width: screenWidth, height: namaHeight + hargaHeight + 16 + 5)
    }
}
