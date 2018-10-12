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

    var requestParameters: [String: String] {
        return [
            "Method": object.method ?? "",
            "Path": object.path ?? "",
            "Description": object.desc ?? "",
            "Headers": prettyPrint(string: object.headers ?? ""),
            "Parameters": prettyPrint(string: object.body ?? "")
        ]
    }

    var responseDate: String {
        return dateFormatter.string(from: object.response?.receivedAt ?? Date())
    }

    var responseParameters: [String: String] {
        guard let response = object.response else {
            return [:]
        }
        return [
            "Status code": String(response.statusCode),
            "Headers": prettyPrint(string: response.headers ?? ""),
            "Body": prettyPrint(string: response.body ?? ""),
            "Description": response.desc ?? "",
            "Error": response.error ?? ""
        ]
    }

    // MARK: - Private

    private func prettyPrint(string: String) -> String {
        guard let data = string.data(using: .utf8, allowLossyConversion: false),
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let prettyData = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted]),
            let result = String(data: prettyData, encoding: .utf8) else {
                return string
        }
        return result
    }
}
