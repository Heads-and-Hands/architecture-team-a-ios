//
//  ARCHRouterTransitioning.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public typealias ARCHInteractiveTransition = (ARCHInteractiveTransitionProtocol & UIPercentDrivenInteractiveTransition)

public typealias ARCHPresentRepresentativeProtocol = (ARCHTransitioningRepresentative & UIViewControllerTransitioningDelegate)

public typealias ARCHPushRepresentativeProtocol = (ARCHTransitioningRepresentative & UINavigationControllerDelegate)

public protocol ARCHRouterTransitioning: class {

    var presentRepresentative: ARCHPresentRepresentativeProtocol? { get set }

    var pushRepresentative: ARCHPushRepresentativeProtocol? { get set }

    var interactiveTransition: ARCHInteractiveTransition? { get set }
}

// MARK: - Transition animation

public protocol ARCHTransitioningRepresentative: class {

    var transitionAnimator: ARCHTransitionAnimatorProtocol? { get set }
}
