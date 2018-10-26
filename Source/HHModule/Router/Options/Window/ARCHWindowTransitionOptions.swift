//
//  ARCHWindowTransitionOptions.swift
//  HHModule
//
//  Created by basalaev on 26/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public struct ARCHWindowTransitionOptions {

    public enum Curve {
        case linear
        case easeIn
        case easeOut
        case easeInOut

        public var function: CAMediaTimingFunction {
            return CAMediaTimingFunction(name: mediaTimingFunctionName)
        }

        private var mediaTimingFunctionName: CAMediaTimingFunctionName {
            switch self {
            case .linear:
                return .linear
            case .easeIn:
                return .easeIn
            case .easeOut:
                return .easeOut
            case .easeInOut:
                return .easeInEaseOut
            }
        }
    }

    public enum Direction {
        case fade
        case toTop
        case toBottom
        case toLeft
        case toRight

        public var transition: CATransition {
            let transition = CATransition()
            transition.type = CATransitionType.push
            switch self {
            case .fade:
                transition.type = CATransitionType.fade
                transition.subtype = nil
            case .toLeft:
                transition.subtype = CATransitionSubtype.fromLeft
            case .toRight:
                transition.subtype = CATransitionSubtype.fromRight
            case .toTop:
                transition.subtype = CATransitionSubtype.fromTop
            case .toBottom:
                transition.subtype = CATransitionSubtype.fromBottom
            }
            return transition
        }
    }

    public var duration: TimeInterval = 0.20
    public var direction: ARCHWindowTransitionOptions.Direction = .toRight
    public var style: ARCHWindowTransitionOptions.Curve = .linear
    public var backgroundColor: UIColor?

    public init(direction: ARCHWindowTransitionOptions.Direction = .toRight, style: ARCHWindowTransitionOptions.Curve = .linear) {
        self.direction = direction
        self.style = style
    }

    public init() {}

    public var animation: CATransition {
        let transition = self.direction.transition
        transition.duration = self.duration
        transition.timingFunction = self.style.function
        return transition
    }
}
