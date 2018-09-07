//
//  CustomPresentInteractor.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 07/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class CustomPresentInteractor: ARCHInteractiveTransition {

    private let maxTranslation: CGFloat = 200.0

    private var viewController: UIViewController?

     var isTransitionInProgress: Bool = false

    func attach(to viewController: UIViewController) {

        self.viewController = viewController

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
            isTransitionInProgress = true
            viewController?.dismiss(animated: true, completion: nil)
        case .changed:
            update(progress)
        case .cancelled:
            isTransitionInProgress = false
        case .ended:
            isTransitionInProgress = false
            progress == 1.0 ? finish() : cancel()
        default:
            return
        }
    }
}

