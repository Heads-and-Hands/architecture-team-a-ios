//
//  ARCHTransitionAnimatorProtocol.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

open class ARCHTransitionAnimator: NSObject, ARCHTransitionAnimatorProtocol {

    weak public var delegate: ARCHTransitionAnimatorDelegate?

    open var transitionDuration: TimeInterval = 1.0

    public var isPresented: Bool = false

    // MARK: - Initialization

    public init(transitionDuration: TimeInterval = 1.0) {
        self.transitionDuration = transitionDuration
    }

    // MARK: - Open

    open func animateAppearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = viewController(from: transitionContext, for: .to) as? UIViewController & ARCHTransitionAnimatorDelegate,
            let fromVC = viewController(from: transitionContext, for: .from) as? UIViewController & ARCHTransitionAnimatorDelegate else {
                return
        }

        let container = transitionContext.containerView

        toVC.view.alpha = 0.0
        container.addSubview(toVC.view)

        delegate?.prepareForAppearance(context: transitionContext, fromViewController: fromVC)

        toVC.view.layoutIfNeeded()

        UIView.animate(
            withDuration: transitionDuration, animations: {
                self.delegate?.willAnimateAppearance(context: transitionContext, fromViewController: fromVC)
                toVC.view.alpha = 1.0
        }, completion: { isFinished in
            self.delegate?.didAnimateAppearance(context: transitionContext, fromViewController: fromVC)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && isFinished)
        })
    }

    open func animateDisappearance(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = viewController(from: transitionContext, for: .to) as? UIViewController & ARCHTransitionAnimatorDelegate,
            let fromVC = viewController(from: transitionContext, for: .from) as? UIViewController & ARCHTransitionAnimatorDelegate else {
                return
        }

        let container = transitionContext.containerView

        toVC.view.frame = fromVC.view.frame

        if let _ = fromVC.navigationController {
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
        }

        delegate?.prepareForDisappearance(context: transitionContext, toViewController: toVC)

        UIView.animate(
            withDuration: transitionDuration, animations: {
                self.delegate?.willAnimateDisappearance(context: transitionContext, toViewController: toVC)
                fromVC.view.alpha = 0.0
        }, completion: { isFinished in
            if transitionContext.transitionWasCancelled {
                fromVC.view.alpha = 1.0
                self.delegate?.didDisappearanceAnimationCanceled(context: transitionContext, toViewController: toVC)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled && isFinished)
            self.delegate?.didAnimateDisappearance(context: transitionContext, toViewController: toVC)
        })
    }

    // MARK: - Public

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animateDisappearance(using: transitionContext)
        } else {
            animateAppearance(using: transitionContext)
        }
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    // MARK: - Public

    public func viewController(from transitionContext: UIViewControllerContextTransitioning, for key: UITransitionContextViewControllerKey) -> UIViewController? {
        guard let viewController = transitionContext.viewController(forKey: key) else {
            return nil
        }

        if let navigationController = viewController as? UINavigationController {
            return navigationController.topViewController
        }
        return viewController
    }
}
