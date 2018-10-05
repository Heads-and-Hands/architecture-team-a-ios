//
//  UIButton.swift
//  HHLensDemo
//
//  Created by Eugene Sorokin on 05/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHLens

let roundedGreyButtonStyle =
    UIButton.lens.titleLabel.font .~ UIFont.boldSystemFont(ofSize: 24.0)
        <> UIButton.lens.titleColor(for: .normal) .~ .red
        <> UIButton.lens.backgroundColor .~ .gray
        <> UIButton.lens.layer.cornerRadius .~ 6.0
