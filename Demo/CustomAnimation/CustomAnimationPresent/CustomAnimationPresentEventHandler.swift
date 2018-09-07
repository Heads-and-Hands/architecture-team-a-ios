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

    var image: UIImage!

    override func viewIsReady() {
        super.viewIsReady()

        self.state.image = image
    }

    func didTapCloseButton() {
        guard let router = router else {
            return
        }

        router.transit(from: router, options: [ARCHRouterDismissOptions()], animated: true)
    }
}
