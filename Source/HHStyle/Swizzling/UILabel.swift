//
//  UILabel.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 18/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

extension UILabel {

    @objc
    private func swizzledSetText(_ text: String) {
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let attributedText = attributedText, !attributedText.string.isEmpty {
            attributes = attributedText.attributes(at: 0, effectiveRange: nil)
        }

        attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    private static var swizzleImplementation: Void = {
        let instance = UILabel()
        guard let instanceClass: AnyClass = object_getClass(instance) else {
            return
        }

        let originalSelector = #selector(setter: UILabel.text)
        let swizzledSelector = #selector(swizzledSetText(_:))

        if let originalMethod = class_getInstanceMethod(instanceClass, originalSelector),
            let swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector) {

            let didAddMethod = class_addMethod(instanceClass,
                                               originalSelector,
                                               method_getImplementation(originalMethod),
                                               method_getTypeEncoding(originalMethod))
            if didAddMethod {
                class_replaceMethod(instanceClass,
                                    swizzledSelector,
                                    method_getImplementation(originalMethod),
                                    method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }()

    public static func swizzle() {
        _ = UILabel.swizzleImplementation
    }
}
