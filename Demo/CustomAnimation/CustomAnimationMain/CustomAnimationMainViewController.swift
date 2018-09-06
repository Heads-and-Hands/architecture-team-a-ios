//
//  CustomAnimationMainViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

final class CustomAnimationMainViewController<Out: CustomAnimationMainViewOutput>: ARCHViewController<CustomAnimationMainState, Out> {

    private var pushButton: UIButton?
    private var presentButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let pushButton = configureButton(with: "PUSH")
        let presentButton = configureButton(with: "PRESENT")

        pushButton.addTarget(self, action: #selector(self.pushButtonDidTap(_:)), for: .touchUpInside)
        presentButton.addTarget(self, action: #selector(self.presentButtonDidTap(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [pushButton, presentButton])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
        ])
    }

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Actions

    @objc
    private func pushButtonDidTap(_ sender: UIButton) {
        output?.didTapPushButton()
    }

    @objc
    private func presentButtonDidTap(_ sender: UIButton) {
        output?.didTapPresentButton()
    }

    // MARK: - Private

    private func configureButton(with title: String) -> UIButton {

        let result = UIButton()

        result.setTitle(title, for: .normal)
        result.setTitleColor(.white, for: .normal)
        result.backgroundColor = .blue
        result.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32.0)

        result.layer.cornerRadius = 15.0

        return result
    }
}
