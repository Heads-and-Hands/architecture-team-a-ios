//
//  ARCHIndicationProvider.swift
//  HHIndication
//
//  Created by basalaev on 31.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHModule

public protocol ARCHIndicationViewProvider {
    func viewBy(state: ARCHIndicationState) -> ARCHIndicationView
}

public extension ARCHIndicationViewProvider where Self: ARCHIndicationView {

    func viewBy(state: ARCHIndicationState) -> ARCHIndicationView {
        return self
    }
}
