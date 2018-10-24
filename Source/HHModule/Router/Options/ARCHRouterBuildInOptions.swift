//
//  ARCHRouterBuildInOptions.swift
//  HHModule
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol ARCHContainer {

    func container(for id: UUID) -> UIView
}

public class ARCHRouterBuildInOptions: ARCHRouterOptions {

    private var id: UUID

    public init(id: UUID) {
        self.id = id
    }

    public func proccess(transition: Transition, animated: Bool) -> Transition {

        guard let parent = transition.from as? UIViewController & ARCHContainer,
            let child = transition.to as? UIViewController else {
                return transition
        }

        child.willMove(toParent: parent)
        parent.addChild(child)

        child.view.translatesAutoresizingMaskIntoConstraints = false
        let container = parent.container(for: id)
        container.addSubview(child.view)

        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: container.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])

        child.didMove(toParent: parent)

        return transition
    }
}
