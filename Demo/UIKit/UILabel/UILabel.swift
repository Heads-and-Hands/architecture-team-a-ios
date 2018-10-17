//
//  UILabel.swift
//  HHLensDemo
//
//  Created by Eugene Sorokin on 05/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHLens

let kGreenLabelStyle =
    UILabel.lens.font .~ UIFont.boldSystemFont(ofSize: 24.0)
        <> UILabel.lens.textColor .~ .green
        <> UILabel.lens.textAlignment .~ .center


