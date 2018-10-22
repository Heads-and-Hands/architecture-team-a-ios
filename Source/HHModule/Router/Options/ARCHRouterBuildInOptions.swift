//
//  ARCHRouterBuildInOptions.swift
//  HHModule
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol ARCHContainer {

    var container: UIView { get }
}

public class ARCHRouterBuildInOptions: ARCHRouterOptions {

    public init() {}

    public func proccess(transition: Transition, animated: Bool) -> Transition {

        guard let parent = transition.from as? UIViewController & ARCHContainer,
            let child = transition.to as? UIViewController else {
                return transition
        }

        child.willMove(toParent: parent)
        parent.addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = false
        parent.container.addSubview(child.view)

        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: parent.container.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: parent.container.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: parent.container.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: parent.container.trailingAnchor)
        ])

        child.didMove(toParent: parent)

        return transition
    }
}
