//
// Created by Xander on 03.08.2018.
// Copyright (c) 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterDismissOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: ARCHRouterOptions.Transition, animated: Bool) -> ARCHRouterOptions.Transition {
        if let from = transition.from as? UIViewController {
            from.dismiss(animated: animated)
        }
        return transition
    }
}
