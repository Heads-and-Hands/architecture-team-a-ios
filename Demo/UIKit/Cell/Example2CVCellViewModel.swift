//
//  Example2CVCellViewModel.swift
//  architecture
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

struct Example2CVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {
    typealias Data = SimpleEntity

    let data: Data

    init(data: Data) {
        self.data = data
    }

    var title: String {
        return "\(data.id)"
    }
}
