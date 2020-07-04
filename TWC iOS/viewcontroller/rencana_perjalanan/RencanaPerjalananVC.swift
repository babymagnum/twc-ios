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
    @IBOutlet weak var button3: CustomButton!
    @IBOutlet weak var view2Right: UIView!
    @IBOutlet weak var view3Left: UIView!
    @IBOutlet weak var view3Right: UIView!
    @IBOutlet weak var view4Left: UIView!
    @IBOutlet weak var button4: CustomButton!
    @IBOutlet weak var barViewHeight: NSLayoutConstraint!
    
    private var disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        barViewHeight.constant = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        setupEvent()
    }
    
    private func setupEvent() {
        view1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view1Click)))
        view2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view2Click)))
        view3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view3Click)))
        view4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(view4Click)))
    }
    
    private func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.mediumGreen
        self.title = "Lupa kata sandi"
        self.containerView.isScrollEnabled = false
    }
    
    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [TujuanWisataVC(), WaktuPesertaVC(), RangkumanVC(), PembayaranVC()]
    }
}

extension RencanaPerjalananVC {
    @objc func view1Click() {
        moveToViewController(at: 0, animated: true)
    }
    
    @objc func view2Click() {
        moveToViewController(at: 1, animated: true)
    }
    
    @objc func view3Click() {
        moveToViewController(at: 2, animated: true)
    }
    
    @objc func view4Click() {
        moveToViewController(at: 3, animated: true)
    }
}
