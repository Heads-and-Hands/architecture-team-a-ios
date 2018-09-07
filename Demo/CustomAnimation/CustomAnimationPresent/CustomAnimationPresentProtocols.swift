//
//  CustomAnimationPresentProtocols.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

protocol CustomAnimationPresentViewOutput: ACRHViewOutput {

    func didTapCloseButton()
}

protocol CustomAnimationPresentModuleInput {

    var image: UIImage! { get set }
}

protocol CustomAnimationPresentModuleOutput: class {
}
