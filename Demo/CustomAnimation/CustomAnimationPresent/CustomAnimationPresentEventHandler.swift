//
//  CustomAnimationPresentEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPresentEventHandler: ARCHEventHandler<CustomAnimationPresentState>, CustomAnimationPresentViewOutput, CustomAnimationPresentModuleInput {

    weak var moduleOutput: CustomAnimationPresentModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
