//
//  ARCHInputFieldViewController.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 09/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

open class ARCHInputFieldViewController<Out: ARCHInputFieldViewOutput, S: ARCHInputFieldStateProtocol>: ARCHViewController<S, Out> {

    let textField = UITextField()

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func prepareRootView() {

        view.backgroundColor = .yellow

        textField.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
    }
}
