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
    private let firstTitleLabel = UILabel(style: [LabelStyle.header, LabelStyle.red])
    private let firstValueLabel = UILabel(style: [LabelStyle.regular, LabelStyle.green, LabelStyle.dischanged])
    private let secondTitleLabel = UILabel(style: [LabelStyle.header, LabelStyle.green])
    private let secondValueLabel = UILabel(style: [LabelStyle.regular, LabelStyle.red, LabelStyle.greenBackground])
#endif

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

#if HHStyles
        firstTitleLabel.text = "Red header"
        firstValueLabel.text = """
        Stubs on Wikipedia often lack comprehen- sive information. The huge cost of edit- ing Wikipedia and the presence of only a limited number of active contributors curb the consistent growth of Wikipedia.
        """
        secondTitleLabel.text = "Green Header"
        secondValueLabel.text = """
        Stubs on Wikipedia often lack comprehen- sive information. The huge cost of edit- ing Wikipedia and the presence of only a limited number of active contributors curb the consistent growth of Wikipedia.
        """

        let container = UIStackView(arrangedSubviews: [firstTitleLabel, firstValueLabel, secondTitleLabel, secondValueLabel])
        container.axis = .vertical
        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)

        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 15.0),
            container.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -15.0)
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
