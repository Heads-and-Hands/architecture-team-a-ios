//
//  ARCHModule.swift
//  HHModule
//
//  Created by basalaev on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHModuleInput {
    func set(moduleOutput: ARCHModuleOutput)
}

public protocol ARCHModuleOutput: class {
}

public protocol ARCHModule: ARCHSubModule {
    var router: ARCHRouter { get }
    var moduleInput: ARCHModuleInput? { get }
    var moduleID: String? { get set }
}

public protocol ARCHSubModule {
    func insert(to module: ARCHRouter, container: UIView, animated: Bool)
}

public extension ARCHSubModule {
    func insert(to module: ARCHRouter, container: UIView, animated: Bool) {}
}

public extension ARCHSubModule where Self: UIView {

    // TODO: Добавить анимацию
    func insert(to module: ARCHRouter, container: UIView, animated: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor),
            leftAnchor.constraint(equalTo: container.leftAnchor),
            rightAnchor.constraint(equalTo: container.rightAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
