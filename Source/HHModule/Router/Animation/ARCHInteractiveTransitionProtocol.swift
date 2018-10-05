//
//  ARCHInteractiveTransitionProtocol.swift
//  HHModule
//
//  Created by Eugene Sorokin on 04/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import Foundation

public protocol ARCHInteractiveTransitionProtocol: class {

    var delegate: ARCHInteractiveTransitionDelegate? { get set }

    var isTransitionInProgress: Bool { get set }

    func attach(to viewController : UIViewController)
}

public protocol ARCHInteractiveTransitionDelegate: class {

    var closeGestureRecognizer: UIGestureRecognizer? { get }

    func progress(for recognizer: UIGestureRecognizer) -> CGFloat
}
