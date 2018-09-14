//
//  HeaderView.swift
//  HHModuleDemo
//
//  Created by basalaev on 07.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule
import HHIndication
import Skeleton

class HeaderView: UIView, ARCHSkeletonView, ARCHViewRenderable {
    typealias State = SkeletonData<String>

    let placeholderView = GradientContainerView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        let baseColor = UIColor(red: 0.56, green: 0.5, blue: 0.49, alpha: 1.0)
        placeholderView.gradientLayer.colors = UIColor.skeletonColors
        placeholderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderView)

        NSLayoutConstraint.activate([
            placeholderView.leftAnchor.constraint(equalTo: leftAnchor),
            placeholderView.rightAnchor.constraint(equalTo: rightAnchor),
            placeholderView.topAnchor.constraint(equalTo: topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        backgroundColor = .green
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: 200)
    }

    // MARK: - ARCHViewRenderable

    func render(state: State) {
        if let indication = state.indication, indication.type == .loading {
            slide(to: .right)
        } else {
            stopSliding()
        }
    }
}

extension HeaderView: GradientsOwner {

    var gradientLayers: [CAGradientLayer] {
        return [placeholderView.gradientLayer]
    }
}
