//
//  ARCHRouterPresentCustomAnimationOptions.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 07/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public class ARCHRouterPresentCustomAnimationOptions: ARCHRouterOptions {

    let animatedTransitioning: ARCHAnimatedTransitioning?

    let interactiveTransition: ARCHInteractiveTransition?

    public init(animatedTransitioning: ARCHAnimatedTransitioning?, interactiveTransition: ARCHInteractiveTransition?) {
        self.animatedTransitioning = animatedTransitioning
        self.interactiveTransition = interactiveTransition
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        let transitioningRepresentative = ARCHPresentTransitioningRepresentative(animatedTransitioning: self.animatedTransitioning, interactiveTransition: self.interactiveTransition)

        if let to = transition.to as? ARCHRouterTransitioning {
            to.presentTransitioningRepresentative = transitioningRepresentative
            to.interactiveTransition = interactiveTransition
        }

        if let to = transition.to as? UIViewController {
            to.transitioningDelegate = transitioningRepresentative
            interactiveTransition?.attach(to: to)
        }

        return transition
    }
}

public class ARCHPresentTransitioningRepresentative: NSObject, ARCHPresentTransitioningRepresentativeProtocol {

    public var animatedTransitioning: ARCHAnimatedTransitioning?

    public var interactiveTransition: ARCHInteractiveTransition?

    init(animatedTransitioning: ARCHAnimatedTransitioning?, interactiveTransition: ARCHInteractiveTransition?) {
        self.animatedTransitioning = animatedTransitioning
        self.interactiveTransition = interactiveTransition
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animatedTransitioning?.isPresented = false
        return self.animatedTransitioning
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.animatedTransitioning?.isPresented = true
        return self.animatedTransitioning
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactiveTransition?.isTransitionInProgress ?? false) ? interactiveTransition : nil
    }
}
