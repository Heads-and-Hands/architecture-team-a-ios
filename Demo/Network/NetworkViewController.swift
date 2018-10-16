//
//  NetworkViewController.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class NetworkViewController: ARCHViewController<NetworkState, NetworkEventHandler> {

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        output?.viewIsReady()
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }
}
