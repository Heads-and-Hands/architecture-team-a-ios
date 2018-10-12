//
// Created by Xander on 01.08.2018.
// Copyright (c) 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterEmbedInNavigationOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: ARCHRouterOptions.Transition, animated: Bool) -> ARCHRouterOptions.Transition {
        guard let toViewController = transition.to as? UIViewController else {
            return transition
        }

        let toNavigationController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        toNavigationController.viewControllers = [toViewController]

        return (transition.from, toNavigationController)
    }
}
