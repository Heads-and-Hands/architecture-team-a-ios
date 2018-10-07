//
//  ChildModuleViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 10/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

final class ChildModuleViewController: ParentModuleViewController<ChildModuleEventHandler, ChildModuleState> {

    private let childView = ChildView(title: "CHILD VIEW", buttonTitle: "CHANGE CHILD VIEW STATE")

    override func prepareRootView() {
        super.prepareRootView()

        childView.output = self

        rootStackView.addArrangedSubview(childView)
    }
}

extension ChildModuleViewController: ChildViewProtocol {

    func childViewNeedsChangeState(_ value: String) {
        output?.childViewNeedsChangeState(value)
    }
}
