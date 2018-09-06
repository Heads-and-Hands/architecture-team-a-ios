//
//  CustomAnimationMainProtocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol CustomAnimationMainViewOutput: ACRHViewOutput {

    func didTapPresentButton()

    func didTapPushButton()
}

protocol CustomAnimationMainModuleInput {
}

protocol CustomAnimationMainModuleOutput: class {
}
