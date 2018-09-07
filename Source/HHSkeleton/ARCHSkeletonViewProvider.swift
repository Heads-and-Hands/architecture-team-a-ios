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

protocol ARCHSkeletonView: ARCHViewInput, GradientsOwner {
    // TODO: Update flags
}

class ARCHSkeletonViewProvider: ARCHIndicationViewProvider, ARCHIndicationView {

    let views: [ARCHSkeletonView]

    init(views: [ARCHSkeletonView]) {
        self.views = views
    }

    // MARK: - ARCHIndicationView

    func showIn(container: UIView, layoutGuide: UILayoutGuide, animated: Bool) {
        views.forEach { view in
            view.slide(to: .left, group: { animatedGroup in
                // TODO: Добавить смещение
            })
        }
    }

    func removeFrom(container: UIView) {
        views.forEach({ $0.stopSliding() })
    }

    // MARK: - ARCHViewInput

    func update(state: Any) -> Bool {
        return true
    }

    func ignoredViews(by state: Any) -> [ARCHViewInput] {
        return views
    }

    func set(visible: Bool) {
         views.forEach({ $0.set(visible: visible) })
    }
}
