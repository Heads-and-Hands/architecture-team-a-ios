//
//  ARCHPagingManager.swift
//  HHModuleDemo
//
//  Created by basalaev on 17.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

open class ARCHPagingManager: NSObject, ARCHPagingManagerInput {

    private var isLoading = false
    private var isLoadingFromTop = false
    private(set) var reachedEnd = false
    private var currentRequest: ARCHPagingManagerCancellable?

    public let pageSize: Int
    public var offset: Int = 0
    private var nextOffset: Int = 0

    public weak var output: ARCHPagingManagerOutput?

    public static let defaultPageSize: Int = 40

    public init(pageSize: Int = ARCHPagingManager.defaultPageSize) {
        self.pageSize = pageSize
        self.nextOffset = pageSize / 2
        super.init()
    }

    // MARK: - ARCHPagingManagerInput

    public func willDisplayCell(indexPath: IndexPath) {
        if indexPath.row >= nextOffset {
            performLoadNextData()
        }
    }

    public func performLoadNextData() {
        guard !isLoading && !reachedEnd else {
            return
        }

        performRequest(offset: offset)
    }

    @objc
    public func performRefreshData() {
        guard !isLoading && !reachedEnd else {
            return
        }

        performRequest(offset: offset)
    }

    // MARK: Private

    private func performRequest(offset: Int, completion: (() -> Void)? = nil) {
        isLoading = true
        currentRequest?.cancel()
        currentRequest = output?.performRequest(offset: offset, pageSize: pageSize, completion: { [weak self] count, total in
            if let count = count, let total = total {
                self?.offset = offset + count
                self?.nextOffset = offset + count / 2
                self?.reachedEnd = offset + count >= total
            }

            completion?()
            self?.isLoading = false
        })
    }
}
