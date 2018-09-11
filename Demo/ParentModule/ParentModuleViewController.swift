//
//  ParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

class ParentModuleViewController<Out: ParentModuleViewOutput, S: ParentModuleStateProtocol>: ARCHViewController<S, Out> {

    let rootStackView = UIStackView()
    let parentView = ParentView(title: "PARENT VIEW", buttonTitle: "CHANGE PARENT VIEW STATE")

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
}

extension ParentModuleViewController: ParentViewProtocol {

    func parentViewNeedsChangeState(_ value: String) {
        output?.parentViewNeedsChangeState(value)
    }
}
