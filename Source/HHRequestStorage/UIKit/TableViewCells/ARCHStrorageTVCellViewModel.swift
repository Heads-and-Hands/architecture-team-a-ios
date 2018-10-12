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

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd hh:mm:ss"
        return formatter
    }()

    // MARK: - ARCHModelInitilizable

    typealias Data = ARCHStorageRequest

    required init(data: Data) {
        self.object = data
    }

    // MARK: - Public

    var title: String {
        return object.objectID.description
    }
}
