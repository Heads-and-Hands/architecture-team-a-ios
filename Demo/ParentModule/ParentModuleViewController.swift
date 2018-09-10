//
//  ParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

final class ParentModuleViewController<Out: ParentModuleViewOutput>: ARCHViewController<ParentModuleState, Out> {

    let rootStackView = UIStackView()
    let parentView = ParentView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareRootView() {

        view.backgroundColor = .white

        rootStackView.axis = .vertical
        rootStackView.spacing = 8.0
        rootStackView.translatesAutoresizingMaskIntoConstraints = false

        parentView.output = self
        rootStackView.addArrangedSubview(parentView)

        view.addSubview(rootStackView)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
            rootStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),

            rootStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func render(state: State) {
        super.render(state: state)
    }
}

extension ParentModuleViewController: ParentViewProtocol {

    func parentViewNeedsChangeState(_ value: String) {
        output?.parentViewNeedsChangeState(value)
    }
}
