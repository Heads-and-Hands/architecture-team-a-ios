//
//  ARCHUserStorage.swift
//  architecture
//
//  Created by basalaev on 14.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

public protocol ARCHUser: Codable {
    var primaryKey: String { get }
}

public protocol ARCHToken: Codable {
    var value: String { get }
}

public protocol ARCHUserStorageDelegate: class {
    func didUpdateUser(from: ARCHUser?, to: ARCHUser?)
}

open class ARCHUserStorage<User: ARCHUser, Token: ARCHToken> {
    public let delegates = NSPointerArray.weakObjects()

    public var user: User?
    public var token: Token?

    public init() {}

    open func save(user: User?, token: Token?) {
        let oldUser = self.user

        self.user = user
        self.token = token

        delegates.compact()
        if let delegates = delegates.allObjects as? [ARCHUserStorageDelegate] {
            delegates.forEach { $0.didUpdateUser(from: oldUser, to: user) }
        }
    }

    public func add(delegate: ARCHUserStorageDelegate) {
        delegates.addObject(delegate as AnyObject)
    }
}

private extension NSPointerArray {

    func addObject(_ object: AnyObject?) {
        guard let strongObject = object else {
            return
        }

        let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
        addPointer(pointer)
    }
}
