//
//  BottomSheetPesertaVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 03/07/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class BottomSheetPesertaVM: BaseViewModel {
    var jumlahAnak = BehaviorRelay(value: 1)
    var jumlahDewasa = BehaviorRelay(value: 1)
}
