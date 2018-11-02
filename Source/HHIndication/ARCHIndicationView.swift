//
//  ARCHIndicationView.swift
//  HHModuleDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit
import HHModule

public protocol ARCHIndicationView: ARCHViewInput {
    func showIn(container: UIView, layoutGuide: UILayoutGuide, animated: Bool)
    func removeFrom(container: UIView)
}
