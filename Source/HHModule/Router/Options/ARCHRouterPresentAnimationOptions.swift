//
//  ARCHRouterPresentAnimationOptions.swift
//  architectureTeamA
//
//  Created by Eugene Sorokin on 07/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public class ARCHRouterPresentAnimationOptions: ARCHRouterOptions {

    let transitionAnimator: ARCHTransitionAnimatorProtocol?

    let interactiveTransition: ARCHInteractiveTransition?

    public init(transitionAnimator: ARCHTransitionAnimatorProtocol? = nil, interactiveTransition: ARCHInteractiveTransition? = nil) {
        self.transitionAnimator = transitionAnimator ?? ARCHTransitionAnimator()
        self.interactiveTransition = interactiveTransition ?? ARCHTransitionInteractor()
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        let transitioningRepresentative = ARCHPresentTransitioningRepresentative(transitionAnimator: self.transitionAnimator, interactiveTransition: self.interactiveTransition)

        interactiveTransition?.delegate = transition.to as? ARCHInteractiveTransitionDelegate
        transitionAnimator?.delegate = transition.to as? ARCHTransitionAnimatorDelegate

        if let to = transition.to as? ARCHRouterTransitioning {
            to.presentRepresentative = transitioningRepresentative
            to.interactiveTransition = interactiveTransition
        }

        if let to = transition.to as? UIViewController {
            to.modalPresentationStyle = .custom
            to.transitioningDelegate = transitioningRepresentative
            interactiveTransition?.attach(to: to)
        }

        return transition
    }
}

public class ARCHPresentTransitioningRepresentative: NSObject, ARCHPresentRepresentativeProtocol {

    public var transitionAnimator: ARCHTransitionAnimatorProtocol?

    public var interactiveTransition: ARCHInteractiveTransition?

    init(transitionAnimator: ARCHTransitionAnimatorProtocol?, interactiveTransition: ARCHInteractiveTransition?) {
        self.transitionAnimator = transitionAnimator
        self.interactiveTransition = interactiveTransition
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionAnimator?.isPresented = false
        return self.transitionAnimator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionAnimator?.isPresented = true
        return self.transitionAnimator
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactiveTransition?.isTransitionInProgress ?? false) ? interactiveTransition : nil
    }
}
