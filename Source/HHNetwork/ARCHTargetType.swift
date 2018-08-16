//
//  ARCHTargetType.swift
//  architecture
//
//  Created by basalaev on 13.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Moya

public protocol ARCHTargetType: TargetType {

    var authorization: Bool { get }
}
