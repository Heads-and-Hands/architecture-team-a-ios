//
//  ContainerParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerParentViewController: ARCHViewController<ContainerParentState, ContainerParentEventHandler>, ARCHContainer {

    var container: UIView = UIView()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }
}
