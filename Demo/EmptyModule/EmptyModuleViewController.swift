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
#elseif HHStyles
import HHStyles
#endif

final class EmptyModuleViewController: ARCHViewController<EmptyModuleState, EmptyModuleEventHandler> {

    private let label = Label()
    private let button = UIButton()

    // MARK: - View life cycle

#if HHStyles
    private let titleLabel = UILabel(style: LabelStyle.bold.rawValue)
    private let valueLabel = UILabel(style: LabelStyle.green.rawValue)
    private let compoundLabel = UILabel(style: LabelStyle.all.rawValue)
#endif

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

#if HHStyles
        titleLabel.text = "Bold"
        valueLabel.text = "Green"
        compoundLabel.text = "BoldGreen"

        let container = UIStackView(arrangedSubviews: [titleLabel, valueLabel, compoundLabel])
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
#else
        button.setTitle("BUTTON", for: .normal)
        label.text = "LABEL"

        [button, label].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            label.bottomAnchor.constraint(equalTo: button.topAnchor)
        ])
#endif

        configure()
    }

    // MARK: - Configure

    private func configure() {
#if HHLens
        _ = button |> kRoundedGreyButtonStyle
        _ = label |> kGreenLabelStyle
#endif
    }
}
