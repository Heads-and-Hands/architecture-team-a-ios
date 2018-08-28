//
//  ARCHIndicationView.swift
//  HHModuleDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule

public protocol ARCHIndicationView: ARCHViewInput {
    func showIn(container: UIView, layoutGuide: UILayoutGuide, animated: Bool)
    func removeFrom(container: UIView)
}

public extension ARCHIndicationView where Self: UIView {

    public func showIn(container: UIView, layoutGuide: UILayoutGuide, animated: Bool) {
        // TODO: Прикрутить анимацию
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)

        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
            rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)
        ])
    }

    public func removeFrom(container: UIView) {
        removeFromSuperview()
    }
}
