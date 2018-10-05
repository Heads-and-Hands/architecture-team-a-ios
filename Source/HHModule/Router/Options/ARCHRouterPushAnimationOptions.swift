//
//  ARCHRouterPushAnimationOptions.swift
//  architectureTeamA
//
//  Created by Eugene Sorokin on 08/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public class ARCHRouterPushAnimationOptions: ARCHRouterOptions {

    let transitionAnimator: ARCHTransitionAnimatorProtocol?

    let interactiveTransition: ARCHInteractiveTransition?

    public init(transitionAnimator: ARCHTransitionAnimatorProtocol? = nil, interactiveTransition: ARCHInteractiveTransition? = nil) {
        self.transitionAnimator = transitionAnimator ?? ARCHTransitionAnimator()
        self.interactiveTransition = interactiveTransition ?? ARCHTransitionInteractor()
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        let transitioningRepresentative = ARCHPushTransitioningRepresentative(transitionAnimator: self.transitionAnimator, interactiveTransition: self.interactiveTransition)

        interactiveTransition?.delegate = transition.to as? ARCHInteractiveTransitionDelegate
        transitionAnimator?.delegate = transition.to as? ARCHTransitionAnimatorDelegate

        if let navigationController = (transition.from as? UIViewController)?.navigationController {
            navigationController.delegate = transitioningRepresentative
        }

        if let to = transition.to as? ARCHRouterTransitioning {
            to.pushRepresentative = transitioningRepresentative
            to.interactiveTransition = interactiveTransition
        }

        if let to = transition.to as? UIViewController {
            interactiveTransition?.attach(to: to)
        }

        return transition
    }
}

public class ARCHPushTransitioningRepresentative: NSObject, ARCHPushRepresentativeProtocol {

    public var transitionAnimator: ARCHTransitionAnimatorProtocol?

    public var interactiveTransition: ARCHInteractiveTransition?

    init(transitionAnimator: ARCHTransitionAnimatorProtocol?, interactiveTransition: ARCHInteractiveTransition?) {
        self.transitionAnimator = transitionAnimator
        self.interactiveTransition = interactiveTransition
    }

    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactiveTransition = interactiveTransition else { return nil }
        return interactiveTransition.isTransitionInProgress ? interactiveTransition : nil
    }

    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        switch operation {
        case .push:
            transitionAnimator?.isPresented = false
            return transitionAnimator
        default:
            transitionAnimator?.isPresented = true
            return transitionAnimator
        }
    }
}
