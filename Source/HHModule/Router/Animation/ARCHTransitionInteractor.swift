//
//  ARCHTransitionInteractor.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

class ARCHTransitionInteractor: ARCHInteractiveTransition {

    weak var delegate: ARCHInteractiveTransitionDelegate?

    var isTransitionInProgress: Bool = false

    private var viewController: UIViewController?

    func attach(to viewController: UIViewController) {

        self.viewController = viewController

        self.configureCloseGesture(for: viewController.view)
    }

    private func configureCloseGesture(for view: UIView) {

        if let gestureRecognizer = delegate?.closeGestureRecognizer {

            gestureRecognizer.addTarget(self, action: #selector(self.closeGestureHandler(_:)))

            view.addGestureRecognizer(gestureRecognizer)
        }
    }

    @objc
    private func closeGestureHandler(_ recognizer: UIPanGestureRecognizer) {

        let progress = delegate?.progress(for: recognizer) ?? 0.0

        switch recognizer.state {
        case .began:
            isTransitionInProgress = true
            if let navigationController = viewController?.navigationController {
                navigationController.popViewController(animated: true)
            } else {
                viewController?.dismiss(animated: true, completion: nil)
            }
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
