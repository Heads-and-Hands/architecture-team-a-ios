//
//  ListExtTVCellViewModel.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

struct ListExtTVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {
    typealias Data = ListExtItem

    let data: Data

    init(data: Data) {
        self.data = data
    }

    var title: String {
        return data.id
    }
}
