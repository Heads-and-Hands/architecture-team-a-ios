//
//  ARCHViewController.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

open class ARCHViewController<S: ARCHState, Out: ACRHViewOutput>: UIViewController, ARCHRouter, ARCHViewInput {

    public typealias State = S

    public var output: Out?

    open func render(state: State) {
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        output?.viewIsReady()
    }
}
