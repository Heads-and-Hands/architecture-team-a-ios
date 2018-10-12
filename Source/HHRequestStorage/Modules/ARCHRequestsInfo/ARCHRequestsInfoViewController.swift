//
//  ARCHRequestsInfoViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsInfoViewController: ARCHViewController<ARCHRequestsInfoState, ARCHRequestsInfoEventHandler> {

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        title = "Request Info"
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }
}
