//
//  HomeVC.swift
//  Eoviz Presence
//
//  Created by Arief Zainuri on 08/04/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import UIKit
import RxSwift
import EzPopup
import DIKit

class HomeVC: UITabBarController {

    @IBOutlet weak var bottomNavigationBar: UITabBar!
    
    private var preference = Preference()
    private var constant = Constant()
    private var networking = Networking()
    
    private var disposeBag = DisposeBag()
    private var currentPage = 0
    private var totalPage = 0
    @Inject private var homeVM: HomeVM
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initBottomNavigation()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    private func checkNotifIcon(isSelected: Bool, hasNotification: Bool) -> UIImage? {
        if hasNotification {
            if isSelected {
                return UIImage(named: "hasNotifikasi")
            } else {
                return UIImage(named: "notifikasiActiveDot")
            }
        } else {
            if isSelected {
                return UIImage(named: "notifikasi")?.tinted(with: UIColor.mediumGreen)!
            } else {
                return UIImage(named: "notifikasi")?.tinted(with: UIColor.brownGreyTwo)!
            }
        }
    }
    
    private func setTabbarItem(hasNotification: Bool) {
        let berandaVC = BerandaVC()
        let pesananVC = PesananVC()
        let kotakMasukVC = KotakMasukVC()
        let profileVC = ProfileVC()
        viewControllers = [berandaVC, pesananVC, kotakMasukVC, profileVC]
        
        berandaVC.tabBarItem = UITabBarItem(title: "home".localize(), image: UIImage(named: "homepage")?.tinted(with: UIColor.brownGreyTwo), selectedImage: UIImage(named: "homepage")?.tinted(with: UIColor.mediumGreen))
        pesananVC.tabBarItem = UITabBarItem(title: "order".localize(), image: UIImage(named: "pesanan")?.tinted(with: UIColor.brownGreyTwo), selectedImage: UIImage(named: "persetujuan")?.tinted(with: UIColor.mediumGreen))
//        kotakMasukVC.tabBarItem = UITabBarItem(title: "notification".localize(), image: checkNotifIcon(isSelected: false, hasNotification: hasNotification), selectedImage: checkNotifIcon(isSelected: true, hasNotification: hasNotification))
        kotakMasukVC.tabBarItem = UITabBarItem(title: "inbox".localize(), image: UIImage(named: "mail")?.tinted(with: UIColor.brownGreyTwo), selectedImage: UIImage(named: "mail")?.tinted(with: UIColor.mediumGreen))
        profileVC.tabBarItem = UITabBarItem(title: "profile".localize(), image: UIImage(named: "profile")?.tinted(with: UIColor.brownGreyTwo), selectedImage: UIImage(named: "profile")?.tinted(with: UIColor.mediumGreen))
        
        setViewControllers(viewControllers, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBar.roundCorners([.topLeft, .topRight], radius: 15)
    }
    
    private func initBottomNavigation() {
        UITabBar.appearance().tintColor = UIColor.mediumGreen
        UITabBar.appearance().backgroundColor = UIColor.white
        tabBar.unselectedItemTintColor = UIColor.brownGreyTwo
        tabBar.backgroundColor = UIColor.whiteThree
        tabBar.addShadow(CGSize(width: 2, height: 4), UIColor.black.withAlphaComponent(0.5), 4, 1)
        
        self.delegate = self
        
        setTabbarItem(hasNotification: false)
    }

}

extension HomeVC: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (tabBar.items)![0] {
        } else if item == (tabBar.items)![1] {
            self.selectedIndex = 1
        } else if item == (tabBar.items)![2] {
            self.selectedIndex = 2
        } else if item == (tabBar.items)![3] {
            self.selectedIndex = 3
        }
    }
}
