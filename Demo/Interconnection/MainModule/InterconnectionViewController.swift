//
//  InterconnectionViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class InterconnectionViewController: ARCHViewController<InterconnectionState, InterconnectionEventHandler> {

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        let containerButton = configureButton("Container", action: #selector(self.containerButtonTapHandler(_:)))
        let scrollViewContainerButton = configureButton("Scroll view container", action: #selector(self.scrollViewButtonTapHandler(_:)))
        let tableSectionContainerButton = configureButton("Table section container", action: #selector(self.tableSectionButtonTapHandler(_:)))
        let tableRowContainerButton = configureButton("Table row container", action: #selector(self.tableRowButtonTapHandler(_:)))

        let stackView = UIStackView(arrangedSubviews: [containerButton, scrollViewContainerButton, tableSectionContainerButton, tableRowContainerButton])

        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 15.0),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -15.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Configuration

    private func configureButton(_ title: String, action: Selector) -> UIButton {
        let button = UIButton()

        button.setTitle(title, for: .normal)

        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .selected)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)

        button.backgroundColor = .gray
        button.clipsToBounds = true
        button.layer.cornerRadius = 6.0
        button.translatesAutoresizingMaskIntoConstraints = false

        button.heightAnchor.constraint(equalToConstant: 36.0).isActive = true

        button.addTarget(self, action: action, for: .touchUpInside)

        return button
    }

    // MARK: - Actions

    @objc
    private func containerButtonTapHandler(_ sender: UIButton) {
    }

    @objc
    private func scrollViewButtonTapHandler(_ sender: UIButton) {
    }

    @objc
    private func tableSectionButtonTapHandler(_ sender: UIButton) {
    }

    @objc
    private func tableRowButtonTapHandler(_ sender: UIButton) {
    }
}
