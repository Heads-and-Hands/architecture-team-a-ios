//
//  CustomPushInteractor.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 08/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

class CustomPushInteractor: ARCHInteractiveTransition {

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
        let verticalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).y)
        let horizontalTranslation = Double(recognizer.translation(in: recognizer.view?.superview).x)
        let translation = CGFloat(sqrt(pow(verticalTranslation, 2.0) + pow(horizontalTranslation, 2.0)))

        let progress: CGFloat = min(translation / maxTranslation, 1.0)

        print("PROGRESS \(progress)")

        switch recognizer.state {
        case .began:
            isTransitionInProgress = true
            viewController?.navigationController?.popViewController(animated: true)
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
