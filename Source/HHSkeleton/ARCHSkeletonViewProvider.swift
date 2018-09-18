//
//  ARCHSkeletonViewProvider.swift
//  HHSkeletonDemo
//
//  Created by basalaev on 11.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHIndication
import HHModule
import Skeleton

public class ARCHSkeletonViewProvider: UIView, ARCHIndicationViewProvider, ARCHIndicationView, GradientsOwner {

    private let gradientView = GradientContainerView()
    private let maskLayer = CAShapeLayer()

    public var animationDirection: Skeleton.Direction = .right
    public let views: [ARCHSkeletonView]

    public init(views: [ARCHSkeletonView]) {
        self.views = views
        super.init(frame: .zero)
        gradientView.layer.mask = maskLayer

        set(skeletonColors: [
            UIColor.lightGray.cgColor,
            UIColor.darkGray.cgColor,
            UIColor.lightGray.cgColor
        ])
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func set(skeletonColors: [CGColor]) {
        gradientView.gradientLayer.colors = skeletonColors
    }

    // MARK: - ARCHViewInput

    public func update(state: Any) -> Bool {
        return true
    }

    // MARK: - GradientsOwner

    public var gradientLayers: [CAGradientLayer] {
        return [gradientView.gradientLayer]
    }

    // MARK: - Override

    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        addSubview(gradientView)
    }

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()

        slide(to: .right)
    }

    public override func removeFromSuperview() {
        super.removeFromSuperview()

        stopSliding()
        views.forEach({ $0.set(isEnableSkeleton: false) })
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        if superview == nil {
            return
        }

        gradientView.frame = bounds
        maskLayer.frame = gradientView.bounds
        maskLayer.path = bezierPath.cgPath
    }

    // MARK: - Private

    private var bezierPath: UIBezierPath {
        let bezierPath = UIBezierPath()

        for view in views {
            view.set(isEnableSkeleton: true)
            for path in view.contours(on: self) {
                bezierPath.append(path)
            }
        }

        return bezierPath
    }
}
