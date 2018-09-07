//
//  CustomPresentInteractor.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 07/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class CustomPresentInteractor: UIPercentDrivenInteractiveTransition {

    private let viewController: UIViewController
    private let maxTranslation: CGFloat = 200.0

    init?(attachTo viewController : UIViewController) {
        self.viewController = viewController

        super.init()

        self.configureCloseGesture(for: viewController.view)
    }

    private func configureCloseGesture(for view: UIView) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(closeGestureHandler(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc
    private func closeGestureHandler(_ recognizer: UIPanGestureRecognizer) {
        let verticalNegativeTranslation = min(recognizer.translation(in: recognizer.view?.superview).y, 0.0)

        let progress: CGFloat = min(-verticalNegativeTranslation / maxTranslation, 1.0)

        print("PROGRESS \(progress)")

        switch recognizer.state {
        case .began:
            viewController.dismiss(animated: true, completion: nil)
            break
        case .changed:
            update(progress)
        case .cancelled:
            break
        case .ended:
            progress == 1.0 ? finish() : cancel()
        default:
            return
        }
    }
}

