//
//  EmptyModuleViewController.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class EmptyModuleViewController: ARCHViewController<EmptyModuleState, EmptyModuleEventHandler> {

    let label = Label()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.frame = view.bounds
        label.textAlignment = .center
        view.addSubview(label)

        view.backgroundColor = .white
    }
}
