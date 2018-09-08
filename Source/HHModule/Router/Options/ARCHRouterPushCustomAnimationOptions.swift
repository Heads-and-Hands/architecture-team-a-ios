//
//  ARCHRouterPresentCustomAnimationOptions.swift
//  architectureTeamA
//
//  Created by Eugene Sorokin on 08/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public class ARCHRouterPushCustomAnimationOptions: ARCHRouterOptions {

    let animatedTransitioning: ARCHAnimatedTransitioning?

    let interactiveTransition: ARCHInteractiveTransition?

    public init(animatedTransitioning: ARCHAnimatedTransitioning?, interactiveTransition: ARCHInteractiveTransition?) {
        self.animatedTransitioning = animatedTransitioning
        self.interactiveTransition = interactiveTransition
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        let transitioningRepresentative = ARCHPushTransitioningRepresentative(animatedTransitioning: self.animatedTransitioning, interactiveTransition: self.interactiveTransition)

        if let navigationController = (transition.from as? UIViewController)?.navigationController {
            navigationController.delegate = transitioningRepresentative
        }

        if let to = transition.to as? ARCHRouterTransitioning {
            to.pushTransitioningRepresentative = transitioningRepresentative
            to.interactiveTransition = interactiveTransition
        }

        if let to = transition.to as? UIViewController {
            interactiveTransition?.attach(to: to)
        }

        return transition
    }
}

public class ARCHPushTransitioningRepresentative: NSObject, ARCHPushTransitioningRepresentativeProtocol {

    public var animatedTransitioning: ARCHAnimatedTransitioning?

    public var interactiveTransition: ARCHInteractiveTransition?

    init(animatedTransitioning: ARCHAnimatedTransitioning?, interactiveTransition: ARCHInteractiveTransition?) {
        self.animatedTransitioning = animatedTransitioning
        self.interactiveTransition = interactiveTransition
    }

    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactiveTransition = interactiveTransition else { return nil }
        return interactiveTransition.isTransitionInProgress ? interactiveTransition : nil
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            animatedTransitioning?.isPresented = false
            return animatedTransitioning
        default:
            animatedTransitioning?.isPresented = true
            return animatedTransitioning
        }
    }
}
