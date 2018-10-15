//
//  ARCHRequestsInfoState.swift
//  architecture
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

struct ARCHRequestsInfoState: ARCHState {

    // MARK: - Parameters

    var requestModel: ARCHStorageRequest?

    // MARK: - Public

    var requestDate: String {
        return dateFormatter.string(from: requestModel?.createdAt ?? Date())
    }

    var requestParameters: [(key: String, value: String)]  {
        return [
            ("Method", requestModel?.method ?? ""),
            ("Path", requestModel?.path ?? ""),
            ("Description", requestModel?.desc ?? ""),
            ("Headers", prettyPrint(string: requestModel?.headers ?? "")),
            ("Parameters", prettyPrint(string: requestModel?.body ?? ""))
        ]
    }

    var responseDate: String {
        return dateFormatter.string(from: requestModel?.response?.receivedAt ?? Date())
    }

    var responseParameters: [(key: String, value: String)] {
        guard let response = requestModel?.response else {
            return []
        }

        return [
            ("Status code", String(response.statusCode)),
            ("Error", response.error ?? ""),
            ("Description", response.desc ?? ""),
            ("Headers", prettyPrint(string: response.headers ?? "")),
            ("Body", prettyPrint(string: response.body ?? ""))
        ]
    }

    // MARK: - Private

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd hh:mm:ss"
        return formatter
    }()

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
