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
    typealias ViewState = String

    func render(state: ViewState) {
        text = state
    }
}
