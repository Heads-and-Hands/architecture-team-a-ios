//
//  ExampleCellViewModel.swift
//  architecture
//
//  Created by basalaev on 08.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

struct ExampleCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {
    typealias Data = SimpleEntity

    let data: SimpleEntity

    init(data: SimpleEntity) {
        self.data = data
    }

    var title: String {
        return data.id
    }
}
