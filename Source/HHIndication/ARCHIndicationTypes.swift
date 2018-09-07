//
//  ARCHIndicationTypes.swift
//  HHIndication
//
//  Created by basalaev on 31.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public struct ARCHIndicationTypes: OptionSet, Hashable {
    public let rawValue: Int

    public static let loading = ARCHIndicationTypes(rawValue: 1 << 0)
    public static let error = ARCHIndicationTypes(rawValue: 1 << 1)
    public static let empty = ARCHIndicationTypes(rawValue: 1 << 2)
    public static let custom = ARCHIndicationTypes(rawValue: 1 << 3)

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public var hashValue: Int {
        return rawValue.hashValue
    }
}
