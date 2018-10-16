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
                Preference(name: "Release", value: "https://yandex.ru", type: .constant, isSelected: false),
                Preference(name: "Debug", value: "https://mail.ru", type: .constant, isSelected: true),
                Preference(name: "Custom", value: "", type: .custom, isSelected: false),
                Preference(name: "Release_1", value: "https://yandex.ru", type: .constant, isSelected: false),
                Preference(name: "Debug_1", value: "https://mail.ru", type: .constant, isSelected: true),
                Preference(name: "Custom_1", value: "", type: .custom, isSelected: false),
                Preference(name: "Release_2", value: "https://yandex.ru", type: .constant, isSelected: false),
                Preference(name: "Debug_2", value: "https://mail.ru", type: .constant, isSelected: true),
                Preference(name: "Custom_2", value: "", type: .custom, isSelected: false),
                Preference(name: "Release_3", value: "https://yandex.ru", type: .constant, isSelected: false),
                Preference(name: "Debug_3", value: "https://mail.ru", type: .constant, isSelected: true),
                Preference(name: "Custom_3", value: "", type: .custom, isSelected: false)
            ]
        }
    }
}
