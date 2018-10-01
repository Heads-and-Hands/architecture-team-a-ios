//
//  IndicationViewProvider.swift
//  HHIndication
//
//  Created by basalaev on 31.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation
import HHIndication

class IndicationViewProvider: ARCHIndicationViewProvider {

    func viewBy(state: ARCHIndicationState) -> ARCHIndicationView {
        return DefaultIndicationView()
    }
}
