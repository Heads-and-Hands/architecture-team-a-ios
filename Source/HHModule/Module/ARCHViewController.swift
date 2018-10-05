//
//  ARCHViewController.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHViewController<S: ARCHState, Out: ACRHViewOutput>:
UIViewController, ARCHRouter, ARCHViewRenderable, ARCHRouterTransitioning, ARCHInteractiveTransitionDelegate, ARCHTransitionAnimatorDelegate {

    public typealias State = S

    public var output: Out?

    public var presentRepresentative: ARCHPresentRepresentativeProtocol?

    public var pushRepresentative: ARCHPushRepresentativeProtocol?

    public var interactiveTransition: ARCHInteractiveTransition?

    open var autorenderIgnoreViews: [ARCHViewInput] {
        return []
    }

    open func render(state: State) {
        var views = autorenderViews
        let substates = self.substates(state: state)

        var index: Int = 0
        while index < views.count {
            let view = views[index]
            var isVisible = false

            for substate in substates where view.update(state: substate) {
                isVisible = true
                break
            }

            view.set(visible: isVisible)
            index += 1
        }

        print("[ARCHViewController] end render(state:)")
    }

    private func substates(state: State) -> [Any] {
        return Mirror(reflecting: state).children.map({ $0.value })
    }

    private var autorenderViews: [ARCHViewInput] {
        return Mirror(reflecting: self).children
            .compactMap({ item -> ARCHViewInput? in
                guard let value = item.value as? ARCHViewInput else {
                    return nil
                }

                if autorenderIgnoreViews.contains(where: { $0 === value }) {
                    return nil
                } else {
                    return value
                }
            })
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        prepareRootView()
        output?.viewIsReady()
    }

    open func prepareRootView() {
    }

    // ARCHInteractiveTransitionDelegate

    open var closeGestureRecognizer: UIGestureRecognizer? {
        return nil
    }

    open func progress(for recognizer: UIGestureRecognizer) -> CGFloat {
        return 0.0
    }

    // ARCHTransitionAnimatorDelegate

    open func willAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func didAnimateAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate){}

    open func willAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func didDisappearanceAnimationCanceled(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func didAnimateDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func prepareForAppearance(context: UIViewControllerContextTransitioning, fromViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func prepareForDisappearance(context: UIViewControllerContextTransitioning, toViewController:  UIViewController & ARCHTransitionAnimatorDelegate) {}

    open func getContextData() -> Any? { return nil }
}
