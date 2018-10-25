//
//  ARCHModuleID+.swift
//  HHIndicationDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

extension ARCHModuleID {

    func displayEmbedNaviVCOn(window: UIWindow?, animated: Bool) {
        let options: [ARCHRouterOptions] = [
            RouterEmbedNaviVCOptions(),
            ARCHRouterWindowOptions()
        ]

        configurator.router.transit(from: window,
                                    options: options,
                                    animated: animated)
    }
}
