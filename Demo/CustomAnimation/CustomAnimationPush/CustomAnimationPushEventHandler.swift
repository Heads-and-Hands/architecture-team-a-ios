//
//  CustomAnimationPushEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationPushEventHandler: ARCHEventHandler<CustomAnimationPushState>, CustomAnimationPushViewOutput, CustomAnimationPushModuleInput {

    weak var moduleOutput: CustomAnimationPushModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }
}
