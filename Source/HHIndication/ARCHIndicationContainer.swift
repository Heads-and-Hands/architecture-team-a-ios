//
//  ARCHIndicationContainer.swift
//  HHModuleDemo
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import UIKit

public protocol ARCHIndicationContainer: class {
    var layoutIndicationGuide: ARCHIndicationLayoutGuide { get }
    var contextView: UIView { get }
}

public extension ARCHIndicationContainer where Self: UIViewController {

    public var layoutIndicationGuide: ARCHIndicationLayoutGuide {
        let guideId = ARCHIndicationLayoutGuide.layoutGuideId

        let layoutGuide = contextView.layoutGuides.first(where: { $0.identifier == guideId })

        if let layoutGuide = layoutGuide as? ARCHIndicationLayoutGuide {
            return layoutGuide
        } else {
            return ARCHIndicationLayoutGuide(view: contextView)
        }
    }

    public var contextView: UIView {
        return view
    }
}
