//
//  EmptyModuleViewController.swift
//  architecture
//
//  Created by basalaev on 06.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class EmptyModuleViewController: ARCHViewController<EmptyModuleState, EmptyModuleEventHandler> {

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }
}
