//
//  ListTVCellViewModel.swift
//  architecture
//
//  Created by HeadsAndHands on 14.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

struct ListTVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {
    typealias Data = ListDataModel

    var data: Data

    init(data: Data) {
        self.data = data
    }

    mutating func changeActive(_ active: Bool) {
        self.data.active = active
    }
}
