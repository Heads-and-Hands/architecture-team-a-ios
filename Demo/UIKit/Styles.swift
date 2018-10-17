//
//  Styles.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHStyles

struct LabelStyle: OptionSet {

    static let bold = LabelStyle(
        rawValue: ARCHStyle<UILabel> {
            $0.font = .systemFont(ofSize: 28.0, weight: .bold)
        })

    static let green = LabelStyle(
        rawValue: ARCHStyle<UILabel> {
            $0.textColor = .green
        })

    static let all: LabelStyle = [.bold, .green]

    // MARK: - OptionSet

    var rawValue: ARCHStyle<UILabel>

    init() {
        rawValue = ARCHStyle<UILabel> { _ in }
    }

    init(rawValue: LabelStyle.RawValue) {
        self.rawValue = rawValue
    }

    mutating func formUnion(_ other: LabelStyle) {
        rawValue = ARCHStyle.compose(rawValue, other.rawValue)
    }

    mutating func formIntersection(_ other: LabelStyle) {
    }

    mutating func formSymmetricDifference(_ other: LabelStyle) {
    }

    static func == (lhs: LabelStyle, rhs: LabelStyle) -> Bool {
        let lhsLabel = UILabel(style: lhs.rawValue)
        let rhsLabel = UILabel(style: rhs.rawValue)
        return lhsLabel == rhsLabel
    }
}
