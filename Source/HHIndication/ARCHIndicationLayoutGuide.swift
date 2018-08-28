//
//  ARCHIndicationLayoutGuide.swift
//  HHModuleDemo
//
//  Created by basalaev on 04.09.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public class ARCHIndicationLayoutGuide: UILayoutGuide {

    static let layoutGuideId = "arch-layout-indication-guide-id"

    public var topConstraint: NSLayoutConstraint?
    public var leftConstraint: NSLayoutConstraint?
    public var rightConstraint: NSLayoutConstraint?
    public var bottomConstraint: NSLayoutConstraint?

    public init(view: UIView) {
        super.init()

        identifier = ARCHIndicationLayoutGuide.layoutGuideId
        registrate(view: view)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func registrate(view: UIView) {
        view.addLayoutGuide(self)

        let topConstraint = topAnchor.constraint(equalTo: view.topAnchor)
        let leftConstraint = leftAnchor.constraint(equalTo: view.leftAnchor)
        let rightConstraint = rightAnchor.constraint(equalTo: view.rightAnchor)
        let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            leftConstraint,
            rightConstraint,
            bottomConstraint
        ])

        self.topConstraint = topConstraint
        self.leftConstraint = leftConstraint
        self.rightConstraint = rightConstraint
        self.bottomConstraint = bottomConstraint
    }
}
