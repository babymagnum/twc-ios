//
//  RencanaPerjalananVC.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 04/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import DIKit
import RxSwift

class RencanaPerjalananVC: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var button2: CustomButton!
    @IBOutlet weak var button3: CustomButton!
    @IBOutlet weak var button4: CustomButton!
    @IBOutlet weak var view1Right: UIView!
    @IBOutlet weak var view2Left: UIView!
    @IBOutlet weak var view2Right: UIView!
    @IBOutlet weak var view3Left: UIView!
    @IBOutlet weak var view3Right: UIView!
    @IBOutlet weak var view4Left: UIView!
    @IBOutlet weak var barViewHeight: NSLayoutConstraint!
    @IBOutlet weak var labelView2: CustomLabel!
    @IBOutlet weak var labelView3: CustomLabel!
    @IBOutlet weak var labelView4: CustomLabel!
    
    @Inject private var rencanaPerjalananVM: RencanaPerjalananVM
    private var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        barViewHeight.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        setupView()
        
        setupEvent()
        
        observeData()
    }
    
    private func observeData() {
        rencanaPerjalananVM.currentRencanaPerjalananPage.subscribe(onNext: { value in
            if value == 0 {
                self.title = "Tujuan wisata"
            } else if value == 1 {
                self.title = "Waktu peserta"
            } else if value == 2 {
                self.title = "Rangkuman"
            } else {
                self.title = "Pembayaran"
            }
            
            self.moveToViewController(at: value, animated: true)
        }).disposed(by: disposeBag)
        
        rencanaPerjalananVM.maxRencanaPerjalananPage.subscribe(onNext: { value in
            UIView.animate(withDuration: 0.2) {
                self.view1Right.backgroundColor = value > 0 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.view2Left.backgroundColor = value > 0 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.button2.backgroundColor = value > 0 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.labelView2.textColor = value > 0 ? UIColor.charcoalGrey : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                
                self.view2Right.backgroundColor = value > 1 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.view3Left.backgroundColor = value > 1 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.button3.backgroundColor = value > 1 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.labelView3.textColor = value > 1 ? UIColor.charcoalGrey : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                
                self.view3Right.backgroundColor = value > 2 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.view4Left.backgroundColor = value > 2 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.button4.backgroundColor = value > 2 ? UIColor.mediumGreen : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                self.labelView4.textColor = value > 2 ? UIColor.charcoalGrey : UIColor.brownGreyTwo.withAlphaComponent(0.8)
                
                self.view.layoutIfNeeded()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupEvent() {
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view1Click)))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view2Click)))
        view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view3Click)))
        view4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view4Click)))
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
        self.containerView.isScrollEnabled = false
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [TujuanWisataVC(), WaktuPesertaVC(), RangkumanVC(), PembayaranVC()]
    }
}

extension RencanaPerjalananVC {
    @objc func view1Click() {
        if rencanaPerjalananVM.maxRencanaPerjalananPage.value < 3 {
            rencanaPerjalananVM.currentRencanaPerjalananPage.accept(0)
        }
    }
    
    @objc func view2Click() {
        if rencanaPerjalananVM.maxRencanaPerjalananPage.value >= 1 && rencanaPerjalananVM.maxRencanaPerjalananPage.value < 3 {
            rencanaPerjalananVM.currentRencanaPerjalananPage.accept(1)
        }
    }
    
    @objc func view3Click() {
        if rencanaPerjalananVM.maxRencanaPerjalananPage.value >= 2 && rencanaPerjalananVM.maxRencanaPerjalananPage.value < 3 {
            rencanaPerjalananVM.currentRencanaPerjalananPage.accept(2)
        }
    }
    
    @objc func view4Click() {
        if rencanaPerjalananVM.maxRencanaPerjalananPage.value >= 3 {
            rencanaPerjalananVM.currentRencanaPerjalananPage.accept(3)
        }
    }
}
