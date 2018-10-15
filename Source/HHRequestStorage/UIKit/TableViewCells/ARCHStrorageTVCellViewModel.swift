//
//  ARCHStorageTVCellViewModel.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 11/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList

class ARCHStorageTVCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {

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

    var requestDate: String {
        return dateFormatter.string(from: object.createdAt ?? Date())
    }

    var responseDate: String {
        guard let response = object.response else {
            return "-"
        }

        return dateFormatter.string(from: response.receivedAt ?? Date())
    }

    var path: String {
        return object.path ?? ""
    }

    var method: String {
        return object.method ?? ""
    }

    var statusCode: String {
        guard let response = object.response else {
            return "-"
        }

        return String(response.statusCode)
    }
}
