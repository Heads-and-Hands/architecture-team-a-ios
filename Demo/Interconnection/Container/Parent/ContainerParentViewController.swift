//
//  ContainerParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ContainerParentViewController: ARCHViewController<ContainerParentState, ContainerParentEventHandler>, ARCHContainer {

    private var container: UIView = UIView()

    private let childStateLabel = Label()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        childStateLabel.font = .systemFont(ofSize: 12.0, weight: .regular)
        childStateLabel.textAlignment = .center
        childStateLabel.textColor = .black

        let button = DefaultButton(title: "Change child state")
        button.addTarget(self, action: #selector(self.changeChildButtonTapHandler(_:)), for: .touchUpInside)

        let closeButon = DefaultButton(title: "Close")
        closeButon.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [container, childStateLabel, button, closeButon])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Actons

    @objc
    private func changeChildButtonTapHandler(_ sender: UIButton) {
        output?.needsChangeChildState()
    }

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - ARCHContainer

    func container(for id: UUID) -> UIView {
        return container
    }
}
