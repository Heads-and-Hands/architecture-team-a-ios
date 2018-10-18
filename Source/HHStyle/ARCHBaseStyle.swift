//
//  ARCHStyleProtocol.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 18/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

open class ARCHBaseStyle<View: UIView>: OptionSet {

    public var rawValue: ARCHStyle<View>

    public required init(rawValue: ARCHStyle<View>) {
        self.rawValue = rawValue
    }

    public required init() {
        self.rawValue = ARCHStyle<View>({ _ in })
    }

    public func formUnion(_ other: ARCHBaseStyle<View>) {
        self.rawValue = ARCHStyle.compose(rawValue, other.rawValue)
    }

    public func formIntersection(_ other: ARCHBaseStyle<View>) {
    }

    public func formSymmetricDifference(_ other: ARCHBaseStyle<View>) {
    }

    public static func == (lhs: ARCHBaseStyle<View>, rhs: ARCHBaseStyle<View>) -> Bool {
        return false
    }
}
