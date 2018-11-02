//
//  ARCHWindow.swift
//  architectureTeamA
//
//  Created by basalaev on 11.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

extension UIWindow: ARCHRouter {

    public var moduleID: String {
        return String()
    }

    public var moduleInput: Any? {
        return self
    }
}
