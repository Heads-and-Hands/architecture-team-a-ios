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
            var release = Preference(name: "Release", value: "https://yandex.ru", type: .constant, isSelected: false)
            var debug = Preference(name: "Debug", value: "http://gdemost.handh.ru/api/v1/", type: .constant, isSelected: false)
            let custom = Preference(name: "Custom", value: "", type: .custom, isSelected: false)

            #if DEBUG
                debug.isSelected = true
            #else
                release.isSelected = true
            #endif

            return [release, debug, custom]
        }
    }
}
