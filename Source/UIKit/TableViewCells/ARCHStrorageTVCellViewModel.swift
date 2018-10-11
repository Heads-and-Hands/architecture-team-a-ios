//
//  ARCHStrorageTVCellViewModel.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ARCHStrorageTVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {

    private var object: Data

    // MARK: - ARCHModelInitilizable

    typealias Data = String

    required init(data: Data) {
        self.object = data
    }

    // MARK: - Public

    var title: String {
        return object
    }
}
