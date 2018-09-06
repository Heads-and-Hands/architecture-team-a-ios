//
//  CustomAnimator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class CustomPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var animationDuration: TimeInterval
    var isPresented: Bool

    init(animationDuration: TimeInterval, isPresented: Bool) {
        self.animationDuration = animationDuration
        self.isPresented = isPresented
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animateDisappearance(using: transitionContext)
        } else {
            animateAppearance(using: transitionContext)
        }
    }

    func animateAppearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CustomAnimationMainViewController<CustomAnimationMainEventHandler>,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CustomAnimationPresentViewController<CustomAnimationPresentEventHandler> else {
                return
        }

        let container = transitionContext.containerView

        let transitionButton = CustomButton(title: "PRESENT")
        transitionButton.frame = fromVC.stackView.convert(fromVC.presentButton.frame, to: fromVC.view)
        container.addSubview(transitionButton)

        container.addSubview(toVC.view)
        toVC.view.frame = fromVC.view.frame
        toVC.view.alpha = 0.0
        toVC.button.alpha = 0.0

        container.bringSubview(toFront: transitionButton)

        fromVC.presentButton.alpha = 0.0

        container.layoutIfNeeded()

        UIView.animate(
            withDuration: animationDuration, animations: {
                transitionButton.frame = toVC.button.frame
                 toVC.view.alpha = 1.0
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionButton.removeFromSuperview()
            toVC.button.alpha = 1.0
        })
    }

    func animateDisappearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CustomAnimationMainViewController<CustomAnimationMainEventHandler>,
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CustomAnimationPresentViewController<CustomAnimationPresentEventHandler> else {
                return
        }

        let container = transitionContext.containerView

        let transitionButton = CustomButton(title: "PRESENT")
        transitionButton.frame = fromVC.button.frame
        container.addSubview(transitionButton)

        container.addSubview(toVC.view)
        toVC.view.frame = fromVC.view.frame
        toVC.view.alpha = 0.0
        toVC.presentButton.alpha = 0.0

        container.bringSubview(toFront: transitionButton)

        fromVC.button.alpha = 0.0

        container.layoutIfNeeded()

        UIView.animate(
            withDuration: animationDuration, animations: {
                transitionButton.frame = toVC.stackView.convert(toVC.presentButton.frame, to: toVC.view)
                toVC.view.alpha = 1.0
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionButton.removeFromSuperview()
            toVC.presentButton.alpha = 1.0
        })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
}
