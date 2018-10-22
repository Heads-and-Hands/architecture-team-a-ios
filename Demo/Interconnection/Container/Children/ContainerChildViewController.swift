//
//  ContainerChildViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerChildViewController: ARCHViewController<ContainerChildState, ContainerChildEventHandler> {

    private let label = UILabel()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 6.0

        let titleLabel = UILabel()
        titleLabel.text = "CHILD MODULE TITLE"
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black

        label.font = .systemFont(ofSize: 12.0, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black

        let button = DefaultButton(title: "Child module action")
        button.addTarget(self, action: #selector(self.buttonTapHandler(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, label, button])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 6.0, left: 6.0, bottom: 6.0, right: 6.0)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
        label.text = state.text
    }

    // MARK: - Actions

    @objc
    private func buttonTapHandler(_ sender: UIButton) {
        output?.chageTextButtonDidTap()
    }
}
