//
//  ARCHRouterBuildInOptions.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public class ARCHRouterWindowOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        if let from = transition.from as? UIWindow, let to = transition.to as? UIViewController {

            // TODO: Добавить поддержку анимации

            from.rootViewController = to
            from.makeKeyAndVisible()
        }

        return transition
    }
}
