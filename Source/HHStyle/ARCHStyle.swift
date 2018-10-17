//
//  ARCHStyle.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public struct ARCHStyle<View: UIView> {

    // MARK: - Static

    static func compose(_ styles: ARCHStyle<View>...) -> ARCHStyle<View> {
        return ARCHStyle { view in
            for style in styles {
                style.apply(to: view)
            }
        }
    }

    public let style: (View) -> Void

    public init(_ style: @escaping (View) -> Void) {
        self.style = style
    }

    public func apply(to view: View) {
        style(view)
    }
}

extension UIView {

    public convenience init<V>(style: ARCHStyle<V>) {
        self.init(frame: .zero)
        apply(style)
    }

    public func apply<V>(_ style: ARCHStyle<V>) {
        guard let view = self as? V else {
            return
        }
        style.apply(to: view)
    }
}
