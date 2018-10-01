//
//  UIColor+.swift
//  HHModuleDemo
//
//  Created by basalaev on 14.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

extension UIColor {

    static var skeletonLight: UIColor {
        return UIColor.lightGray
    }

    static var skeletonDark: UIColor {
        return UIColor.darkGray
    }

    static var skeletonColors: [CGColor] {
        return [skeletonLight.cgColor,
                skeletonDark.cgColor,
                skeletonLight.cgColor]
    }
}
