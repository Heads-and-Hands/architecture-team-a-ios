//
//  ARCHRouterWindowOptions.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterWindowOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: ARCHTransition, animated: Bool) -> ARCHTransition {
        if let from = transition.from as? UIWindow, let to = transition.to as? UIViewController {

            // TODO: Добавить поддержку анимации

            from.rootViewController = to
            from.makeKeyAndVisible()
        }

        return transition
    }
}
