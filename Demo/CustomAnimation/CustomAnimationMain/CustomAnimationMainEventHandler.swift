//
//  CustomAnimationMainEventHandler.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class CustomAnimationMainEventHandler: ARCHEventHandler<CustomAnimationMainState>, CustomAnimationMainViewOutput, CustomAnimationMainModuleInput {

    weak var moduleOutput: CustomAnimationMainModuleOutput?

    override func viewIsReady() {
        super.viewIsReady()
    }

    func didTapPresentButton() {
        guard let router = router else {
            return
        }

        CustomAnimationPresentConfigurator(moduleIO: nil).router.transit(from: router, options: [ARCHRouterPresentOptions()], animated: true)
    }

    func didTapPushButton() {
    }
}
