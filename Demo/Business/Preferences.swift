//
//  File.swift
//  HHNetworkDemo
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHPreferences

enum Preferences: String {
    case networkBasePath = "NETWORK_BASE_PATH"

    func preferences() -> [Preference] {
        switch self {
        case .networkBasePath:
            return [
                Preference(name: "Debug", value: "http://gdemost.handh.ru/api/v1/", type: .constant, isSelected: false),
                Preference(name: "Release", value: "https://yandex.ru", type: .constant, isSelected: true),
                Preference(name: "Custom", value: "", type: .custom, isSelected: false)
            ]
        }
    }
}
