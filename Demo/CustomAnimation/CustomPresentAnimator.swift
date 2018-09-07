//
//  CustomAnimator.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

class CustomPresentAnimator: NSObject, ARCHAnimatedTransitioning {

    var isPresented: Bool = false
    var transitionDuration: TimeInterval

    init(transitionDuration: TimeInterval = 1.0) {
        self.transitionDuration = transitionDuration
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

        let imageView = UIImageView(image: fromVC.currentImage)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = fromVC.currentFrame ?? .zero

        toVC.view.alpha = 0.0
        container.addSubview(toVC.view)
        container.addSubview(imageView)

        UIView.animate(
            withDuration: transitionDuration, animations: {
                imageView.frame = toVC.view.frame
        }, completion: { isFinished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            imageView.removeFromSuperview()
            toVC.view.alpha = 1.0
        })
    }

    func animateDisappearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CustomAnimationMainViewController<CustomAnimationMainEventHandler>,
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? CustomAnimationPresentViewController<CustomAnimationPresentEventHandler> else {
                return
        }

        let container = transitionContext.containerView

        toVC.view.frame = fromVC.view.frame
        isPresented ? container.insertSubview(toVC.view, belowSubview: fromVC.view) : container.addSubview(toVC.view)

        let imageView = UIImageView(image: fromVC.imageView.image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = fromVC.view.frame
        container.addSubview(imageView)

        fromVC.view.alpha = 0.0

        UIView.animate(
            withDuration: transitionDuration, animations: {
                imageView.frame = toVC.currentFrame ?? .zero
        }, completion: { isFinished in
            if transitionContext.transitionWasCancelled {
                fromVC.view.alpha = 1.0
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            imageView.removeFromSuperview()
        })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
}
