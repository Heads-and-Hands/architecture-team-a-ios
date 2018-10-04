//
//  ARCHTransitionHandler.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public protocol ARCHRouterOptions {
    typealias Transition = (from: AnyObject, to: AnyObject)
    func proccess(transition: Transition, animated: Bool) -> Transition
}

public protocol ARCHRouter: class {
    func transit(from: ARCHRouter, options: [ARCHRouterOptions], animated: Bool)
}

public extension ARCHRouter {

    func transit(from: ARCHRouter, options: [ARCHRouterOptions], animated: Bool) {
        let transition = (from as AnyObject, self as AnyObject)
        _ = options.reduce(transition) { $1.proccess(transition: $0, animated: animated) }
    }
}

public typealias ARCHInteractiveTransition = (ARCHInteractiveTransitionProtocol & UIPercentDrivenInteractiveTransition)

public typealias ARCHPresentRepresentativeProtocol = (ARCHTransitioningRepresentative & UIViewControllerTransitioningDelegate)

public typealias ARCHPushRepresentativeProtocol = (ARCHTransitioningRepresentative & UINavigationControllerDelegate)

public protocol ARCHRouterTransitioning: class {

    var presentRepresentative: ARCHPresentRepresentativeProtocol? { get set }

    var pushRepresentative: ARCHPushRepresentativeProtocol? { get set }

    var interactiveTransition: ARCHInteractiveTransition? { get set }
}

public protocol ARCHTransitioningRepresentative: class {

    var animatedTransitioning: ARCHAnimatedTransitioning? { get set }
}

public protocol ARCHAnimatedTransitioning: UIViewControllerAnimatedTransitioning {

    var isPresented: Bool { get set }
}

public protocol ARCHInteractiveTransitionProtocol: class {

    var isTransitionInProgress: Bool { get set }

    func attach(to viewController : UIViewController)
}
