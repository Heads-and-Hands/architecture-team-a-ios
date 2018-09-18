//
//  IndicationDemoState.swift
//  architecture
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHModule

struct IndicationDemoState: ARCHState {
    var header: HeaderViewState?
    var list: [SimpleEntity]?
    var indication: IndicationState?
}
