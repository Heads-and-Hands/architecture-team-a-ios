//
//  CustomPushAnimator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 08/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

class CustomPushAnimator: ARCHTransitionAnimator {

    override func animateAppearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = viewController(from: transitionContext, for: .from) as? CustomAnimationMainViewController<CustomAnimationMainEventHandler>,
            let toVC = viewController(from: transitionContext, for: .to) as? CustomAnimationPushViewController<CustomAnimationPushEventHandler> else {
                return
        }

        let container = transitionContext.containerView

        let imageView = UIImageView(image: fromVC.currentImage)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = fromVC.currentFrame ?? .zero

        toVC.view.alpha = 0.0
        toVC.imageView.alpha = 0.0
        container.addSubview(toVC.view)
        container.addSubview(imageView)

        toVC.view.layoutIfNeeded()

        UIView.animate(
            withDuration: transitionDuration, animations: {
                imageView.frame = toVC.imageView.frame
                toVC.view.alpha = 1.0
        }, completion: { isFinished in
            toVC.imageView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && isFinished)
            imageView.removeFromSuperview()
        })
    }

    override func animateDisappearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = viewController(from: transitionContext, for: .to) as? CustomAnimationMainViewController<CustomAnimationMainEventHandler>,
            let fromVC = viewController(from: transitionContext, for: .from) as? CustomAnimationPushViewController<CustomAnimationPushEventHandler> else {
                return
        }

        let container = transitionContext.containerView

        toVC.view.frame = fromVC.view.frame
        container.insertSubview(toVC.view, belowSubview: fromVC.view)

        let imageView = UIImageView(image: fromVC.imageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = fromVC.imageView.frame
        container.addSubview(imageView)

        fromVC.imageView.alpha = 0.0

        UIView.animate(
            withDuration: transitionDuration, animations: {
                imageView.frame = toVC.currentFrame ?? .zero
                fromVC.view.alpha = 0.0
        }, completion: { isFinished in
            if transitionContext.transitionWasCancelled {
                fromVC.view.alpha = 1.0
                fromVC.imageView.alpha = 1.0
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && isFinished)
            imageView.removeFromSuperview()
        })
    }
}
