//
//  OnboardingVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 27/06/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit

class OnboardingVC: BaseViewController, UICollectionViewDelegate {

    @IBOutlet weak var buttonSkip: CustomButton!
    @IBOutlet weak var buttonYukMulai: CustomButton!
    @IBOutlet weak var collectionOnboarding: UICollectionView!
    @IBOutlet weak var view1: CustomView!
    @IBOutlet weak var view2: CustomView!
    @IBOutlet weak var view3: CustomView!
    @IBOutlet weak var view4: CustomView!
    
    private var listPageIndicator = [UIView]()
    private var listOnboarding = [
        OnboardingItem(image: "group658", title: "Buat paket wisata dengan mudah", description: "Atur agenda, tujuan wisata dan durasi kunjungan dengan mudah"),
        OnboardingItem(image: "group659", title: "Buat paket wisata dengan mudah", description: "Atur agenda, tujuan wisata dan durasi kunjungan dengan mudah"),
        OnboardingItem(image: "group661", title: "Buat paket wisata dengan mudah", description: "Atur agenda, tujuan wisata dan durasi kunjungan dengan mudah"),
        OnboardingItem(image: "group662", title: "Buat paket wisata dengan mudah", description: "Atur agenda, tujuan wisata dan durasi kunjungan dengan mudah")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
    }

    private func initCollectionView() {
        listPageIndicator.append(view1)
        listPageIndicator.append(view2)
        listPageIndicator.append(view3)
        listPageIndicator.append(view4)
        collectionOnboarding.register(UINib(nibName: "OnboardingCell", bundle: .main), forCellWithReuseIdentifier: "OnboardingCell")
        collectionOnboarding.delegate = self
        collectionOnboarding.dataSource = self
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        onPageChange(currentPage: currentPage)
        UIView.animate(withDuration: 0.2) {
            self.buttonSkip.isHidden = currentPage == 3
            self.buttonYukMulai.isHidden = currentPage < 3
        }
    }
    
    private func onPageChange(currentPage: Int) {
        for (index, item) in listPageIndicator.enumerated() {
            UIView.animate(withDuration: 0.2) {
                item.backgroundColor = index == currentPage ? UIColor.mediumGreen : UIColor.mediumGreen.withAlphaComponent(0.2)
            }
        }
    }
}

extension OnboardingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOnboarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        cell.item = listOnboarding[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = listOnboarding[indexPath.item]
        let titleHeight = item.title.getHeight(withConstrainedWidth: screenWidth - 80, font: UIFont(name: "SFProDisplay-Bold", size: 24 + PublicFunction.dynamicSize()))
        let descriptionHeight = item.description.getHeight(withConstrainedWidth: screenWidth - 80, font: UIFont(name: "SFProDisplay-Regular", size: 16 + PublicFunction.dynamicSize()))
        let imageHeight = screenWidth * 0.7
        return CGSize(width: screenWidth, height: titleHeight + descriptionHeight + imageHeight + 24 + 22 + 34)
    }
}

extension OnboardingVC {
    @IBAction func yukMulaiClick(_ sender: Any) {
    }
    
    @IBAction func skipClick(_ sender: Any) {
    }
}
