//
//  ViewController.swift
//  HHLensDemo
//
//  Created by Eugene Sorokin on 05/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHLens

class ViewController: UIViewController {

    private let label = UILabel()
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

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

    // MARK: - Configure

    private func configure() {
        _ = button |> roundedGreyButtonStyle
        _ = label |> greenLabelStyle
    }
}

