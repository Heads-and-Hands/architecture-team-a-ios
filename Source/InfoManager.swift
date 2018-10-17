//
//  InfoManager.swift
//  HHModuleDemo
//
//  Created by Eugene Sorokin on 17/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol InfoManagerProtocol {

    var delegate: InfoManagerDelegate? { get set }

    func presentValues(from viewController: UIViewController)
}

public protocol InfoManagerDelegate: class {

    var values: [(key: String, value: String)] { get }
}

public class InfoManager: InfoManagerProtocol {

    // MARK: - Singleton

    public weak var delegate: InfoManagerDelegate?

    public init() {}

    public func presentValues(from viewController: UIViewController) {

        let vc = InfoManagerViewController()
        vc.values = delegate?.values ?? []
        viewController.present(vc, animated: true, completion: nil)
    }
}
