//
//  UILabel+Skeleton.swift
//  HHSkeletonDemo
//
//  Created by basalaev on 18.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHSkeleton

extension UILabel: ARCHSkeletonView {

    public func contours(on rootView: UIView) -> [UIBezierPath] {
        let frame = rootView.convert(bounds, from: self)
        let cornerRadius: CGFloat = 3.0
        let path = UIBezierPath(roundedRect: frame, cornerRadius: cornerRadius)
        return [path]
    }
}
