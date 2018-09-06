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

    let pushButton = CustomButton(title: "PUSH")
    let presentButton = CustomButton(title: "PRESENT")
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        pushButton.addTarget(self, action: #selector(self.pushButtonDidTap(_:)), for: .touchUpInside)
        presentButton.addTarget(self, action: #selector(self.presentButtonDidTap(_:)), for: .touchUpInside)

        [pushButton, presentButton].forEach({
            self.stackView.addArrangedSubview($0)
        })

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
}

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 32.0)

        layer.cornerRadius = 15.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
