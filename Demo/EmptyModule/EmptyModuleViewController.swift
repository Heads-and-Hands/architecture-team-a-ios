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

    private let label = Label()
    private let button = UIButton()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

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

        configure()
    }

//    override func render(state: ViewState) {
//        super.render(state: state)
//        
//        print("[\(Thread.isMainThread ? "main" : "back")]render text \(state.text)")
//        output?.updateText()
//        label.text = state.text
//    }

    // MARK: - Configure

    private func configure() {
#if HHLens
        _ = button |> kRoundedGreyButtonStyle
        _ = label |> kGreenLabelStyle
#endif
    }
}
