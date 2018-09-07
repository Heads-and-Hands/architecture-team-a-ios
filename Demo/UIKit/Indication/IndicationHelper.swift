//
//  IndicationHelper.swift
//  HHModuleDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHIndication

class IndicationHelper: ARCHIndicationHelper<IndicationState> {

    static var defaultProviders: [ARCHIndicationTypes: ARCHIndicationViewProvider] {
        let type: ARCHIndicationTypes = [.loading, .empty, .error]
        return [type: IndicationViewProvider()]
    }

    override init() {
        super.init()

        providers = IndicationHelper.defaultProviders
    }
}
