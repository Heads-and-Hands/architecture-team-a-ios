//
//  UIView.swift
//  HHStyles
//
//  Created by Eugene Sorokin on 18/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

extension UIView {

    public convenience init<V>(style: ARCHBaseStyle<V>) {
        self.init(frame: .zero)
        apply(style)
    }

    public func apply<V>(_ style: ARCHBaseStyle<V>) {
        guard let view = self as? V else {
            return
        }

        if self.isKind(of: UILabel.self) {
            UILabel.swizzle()
        }

        style.rawValue.apply(to: view)
    }
}
