//
//  DaftarJadiAgenVM.swift
//  TWC iOS
//
//  Created by Arief Zainuri on 18/08/20.
//  Copyright © 2020 Gama Techno. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

class DaftarJadiAgenVM: BaseViewModel {
    var currentRencanaPerjalananPage = BehaviorRelay(value: 0)
    var maxRencanaPerjalananPage = BehaviorRelay(value: 0)
}
