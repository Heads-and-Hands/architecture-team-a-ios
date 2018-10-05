//
//  ARCHTransitionAnimatorProtocol.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol ARCHTransitionAnimatorProtocol: UIViewControllerAnimatedTransitioning {

    var delegate: ARCHTransitionAnimatorDelegate? { get set }

    var isPresented: Bool { get set }
}

public protocol ARCHTransitionAnimatorDelegate: class {

    func willAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func didAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func willAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func didDisappearanceAnimationCanceled(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func didAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func prepareForAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func prepareForDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate)

    func getContextData() -> Any?
}
