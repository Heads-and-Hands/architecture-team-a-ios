//
//  ARCHTransitionInteractor.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

open class ARCHTransitionInteractor: ARCHInteractiveTransition {

    weak public var delegate: ARCHInteractiveTransitionDelegate?

    public var isTransitionInProgress: Bool = false

    public var viewController: UIViewController?

    public func attach(to viewController: UIViewController) {
        self.viewController = viewController
        self.configureCloseGesture(for: viewController.view)
    }

    public func configureCloseGesture(for view: UIView) {
        if let gestureRecognizer = delegate?.closeGestureRecognizer {
            gestureRecognizer.addTarget(self, action: #selector(self.closeGestureHandler(_:)))
            view.addGestureRecognizer(gestureRecognizer)
        }
    }

    // MARK: - Actions

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
