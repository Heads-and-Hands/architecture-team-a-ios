//
//  DefaultButton.swift
//  HHInterconnectionDemo
//
//  Created by Eugene Sorokin on 22/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {

    // MARK: - Initialization

    init(title: String) {
        super.init(frame: .zero)

        backgroundColor = .gray

        setTitle(title, for: .normal)

        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .selected)
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)

        titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)

        clipsToBounds = true

        layer.cornerRadius = 6.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override var intrinsicContentSize: CGSize {
        return CGSize(width: -1.0, height: 36.0)
    }
}
