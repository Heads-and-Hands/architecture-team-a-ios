//
//  Label.swift
//  HHModuleDemo
//
//  Created by basalaev on 27.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import UIKit

class Label: UILabel, ARCHViewRenderable {
    typealias State = String

    func render(state: State) {
        text = state
    }
}
