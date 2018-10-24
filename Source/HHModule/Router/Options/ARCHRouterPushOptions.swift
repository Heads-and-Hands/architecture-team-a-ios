//
//  ARCHRouterPushOptions.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterPushOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: ARCHTransition, animated: Bool) -> ARCHTransition {
        guard let fromViewController = transition.from as? UIViewController else {
            return transition
        }

        guard let toViewController = transition.to as? UIViewController else {
            return transition
        }

        guard let navigationController = fromViewController.navigationController else {
            return transition
        }

        navigationController.pushViewController(toViewController, animated: animated)

        return (navigationController, toViewController)
    }
}
