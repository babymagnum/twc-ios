//
//  PilihTujuanWisataVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 06/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import DIKit

class PilihTujuanWisataVC: BaseViewController, UICollectionViewDelegate {
    
    var selectedHari: Int?
    
    @IBOutlet weak var loadingDieng: UIActivityIndicatorView!
    @IBOutlet weak var loadingMagelang: UIActivityIndicatorView!
    @IBOutlet weak var loadingYogyakarta: UIActivityIndicatorView!
    @IBOutlet weak var collectionYogyakarta: UICollectionView!
    @IBOutlet weak var collectionYogyakartaHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionMagelang: UICollectionView!
    @IBOutlet weak var collectionMagelangHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionDieng: UICollectionView!
    @IBOutlet weak var collectionDiengHeight: NSLayoutConstraint!
    
    @Inject private var pilihTujuanWisataVM: PilihTujuanWisataVM
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupCollection()
        
        observeData()
        
        pilihTujuanWisataVM.getTujuanWisata()
    }
    
    private func observeData() {
        pilihTujuanWisataVM.listDieng.subscribe(onNext: { value in
            if value.count > 0 {
                self.collectionDieng.reloadData()
                self.collectionDieng.layoutSubviews()
                
                UIView.animate(withDuration: 0.2) {
                    self.loadingDieng.isHidden = true
                    self.collectionDiengHeight.constant = self.screenWidth * 0.43
                    self.view.layoutIfNeeded()
                }
            }
        }).disposed(by: disposeBag)
        
        pilihTujuanWisataVM.listMagelang.subscribe(onNext: { value in
            if value.count > 0 {
                self.collectionMagelang.reloadData()
                self.collectionMagelang.layoutSubviews()
                
                UIView.animate(withDuration: 0.2) {
                    self.loadingMagelang.isHidden = true
                    self.collectionMagelangHeight.constant = self.screenWidth * 0.43
                    self.view.layoutIfNeeded()
                }
            }
        }).disposed(by: disposeBag)
        
        pilihTujuanWisataVM.listYogyakarta.subscribe(onNext: { value in
            if value.count > 0 {
                self.collectionYogyakarta.reloadData()
                self.collectionYogyakarta.layoutSubviews()
                
                UIView.animate(withDuration: 0.2) {
                    self.loadingYogyakarta.isHidden = true
                    self.collectionYogyakartaHeight.constant = self.screenWidth * 0.43
                    self.view.layoutIfNeeded()
                }
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
        self.title = "Pilih tujuan wisata"
    }
    
    private func setupCollection() {
        collectionYogyakarta.register(UINib(nibName: "PilihTujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "PilihTujuanWisataCell")
        collectionMagelang.register(UINib(nibName: "PilihTujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "PilihTujuanWisataCell")
        collectionDieng.register(UINib(nibName: "PilihTujuanWisataCell", bundle: .main), forCellWithReuseIdentifier: "PilihTujuanWisataCell")
        collectionYogyakarta.delegate = self
        collectionYogyakarta.dataSource = self
        collectionMagelang.delegate = self
        collectionMagelang.dataSource = self
        collectionDieng.delegate = self
        collectionDieng.dataSource = self
    }
}

extension PilihTujuanWisataVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionYogyakarta {
            return pilihTujuanWisataVM.listYogyakarta.value.count
        } else if collectionView == collectionMagelang {
            return pilihTujuanWisataVM.listMagelang.value.count
        } else {
            return pilihTujuanWisataVM.listDieng.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionYogyakarta {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PilihTujuanWisataCell", for: indexPath) as! PilihTujuanWisataCell
            cell.item = pilihTujuanWisataVM.listYogyakarta.value[indexPath.item]
            cell.buttonAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonAddYogyakarta(sender:))))
            return cell
        } else if collectionView == collectionMagelang {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PilihTujuanWisataCell", for: indexPath) as! PilihTujuanWisataCell
            cell.item = pilihTujuanWisataVM.listMagelang.value[indexPath.item]
            cell.buttonAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonAddMagelang(sender:))))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PilihTujuanWisataCell", for: indexPath) as! PilihTujuanWisataCell
            cell.item = pilihTujuanWisataVM.listDieng.value[indexPath.item]
            cell.buttonAdd.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(buttonAddDieng(sender:))))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth * 0.7, height: screenWidth * 0.43)
    }
}

extension PilihTujuanWisataVC {
    private func addTujuanWisata(item: PilihanTujuanWisataModel) {
        PublicFunction.showUnderstandDialog(self, item.nama, "Yakin ingin menambah \(item.nama) ke dalam tujuan wisata anda?", "Tambahkan", "Cancel") {
            self.rencanaPerjalananVM.addTujuanWisata(tujuanWisata: TujuanWisataModel(id: self.rencanaPerjalananVM.listTujuanWisataCounter.value, name: item.nama, image: item.image, harga: item.harga, durasi: item.durasi, hari: self.selectedHari ?? 0))
        }
    }
    
    @objc func buttonAddYogyakarta(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionYogyakarta.indexPathForItem(at: sender.location(in: collectionYogyakarta)) else { return }
        addTujuanWisata(item: pilihTujuanWisataVM.listYogyakarta.value[indexPath.item])
    }
    
    @objc func buttonAddMagelang(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionMagelang.indexPathForItem(at: sender.location(in: collectionMagelang)) else { return }
        addTujuanWisata(item: pilihTujuanWisataVM.listMagelang.value[indexPath.item])
    }
    
    @objc func buttonAddDieng(sender: UITapGestureRecognizer) {
        guard let indexPath = collectionDieng.indexPathForItem(at: sender.location(in: collectionDieng)) else { return }
        addTujuanWisata(item: pilihTujuanWisataVM.listDieng.value[indexPath.item])
    }
    
    @IBAction func selengkapnyaDiengClick(_ sender: Any) {
    }
    
    @IBAction func selengkapnyaYogyakartaClick(_ sender: Any) {
    }
    
    @IBAction func selengkapnyaMagelangClick(_ sender: Any) {
    }
    
}
