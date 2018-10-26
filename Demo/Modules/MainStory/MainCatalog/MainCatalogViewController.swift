//
//  MainCatalogViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 25/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class MainCatalogViewController: ARCHViewController<MainCatalogState, MainCatalogEventHandler> {

    private let valueLabel = Label()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        let label = UILabel()
        label.text = "MainStory catalog page"
        label.textAlignment = .center

        valueLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        valueLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [label, valueLabel])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: ViewState) {
        super.render(state: state)
    }
}
