//
//  ARCHRouterWindowOptions.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public class ARCHRouterBuildInOptions: ARCHRouterOptions {

    private let container: UIView

    public init(container: UIView) {
        self.container = container
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {
        if let from = transition.from as? UIViewController, let to = transition.to as? UIViewController {

            to.willMove(toParent: from)
            from.addChild(to)

            to.view.translatesAutoresizingMaskIntoConstraints = false

            container.addSubview(to.view)

            NSLayoutConstraint.activate([
                to.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                to.view.topAnchor.constraint(equalTo: container.topAnchor),
                to.view.rightAnchor.constraint(equalTo: container.rightAnchor),
                to.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
            ])

            to.didMove(toParent: from)
        }

        return transition
    }
}
