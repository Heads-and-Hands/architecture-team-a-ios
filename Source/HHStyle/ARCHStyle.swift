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

    public static func compose(_ styles: ARCHStyle<View>...) -> ARCHStyle<View> {
        return ARCHStyle { view in
            for style in styles {
                style.apply(to: view)
            }
        }
    }

    // MARK: - Public

    public let style: (View) -> Void

    // MARK: - Initialization

    public init(_ style: @escaping (View) -> Void) {
        self.style = style
    }

    public func apply(to view: View) {
        style(view)
    }
}
