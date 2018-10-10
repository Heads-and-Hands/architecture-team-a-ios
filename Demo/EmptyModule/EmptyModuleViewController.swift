//
//  EmptyModuleViewController.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
#if HHLens
import HHLens
#endif

final class EmptyModuleViewController: ARCHViewController<EmptyModuleState, EmptyModuleEventHandler> {

    let nameFieldContainer = UIView()
    let emailFieldContainer = UIView()
    let phoneFieldContainer = UIView()

    private let stackView = UIStackView()
    private let label = Label()
    private let button = UIButton()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 15.0),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -15.0),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100.0)

        ])

        var views: [UIView] = []

        views = [button, label, nameFieldContainer, emailFieldContainer, phoneFieldContainer]

        views.forEach {
            self.stackView.addArrangedSubview($0)
        }

        configure()
    }

    // MARK: - Configure

    private func configure() {
#if HHLens
        _ = button |> kRoundedGreyButtonStyle <> UIButton.lens.title(for: .normal) .~ "BUTTON CUSTOMIZED WITH LENS"
        _ = label |> kGreenLabelStyle <> UILabel.lens.text .~ "LABEL CUSTOMIZED WITH LENS"
#endif
    }
}
