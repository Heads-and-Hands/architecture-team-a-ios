//
//  ARCHPagingManager.swift
//  HHModuleDemo
//
//  Created by basalaev on 17.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import Foundation

open class ARCHPagingManager: NSObject, ARCHPagingManagerInput {

    // IndexPath ячейки, nextOffset - граница срабатывания
    public typealias TriggerBlock = (IndexPath, Int) -> Bool

    private var isLoading = false
    private var isLoadingFromTop = false
    private(set) var reachedEnd = false
    private var currentRequest: ARCHPagingManagerCancellable?
    private let triggerBlock: TriggerBlock

    public let pageSize: Int
    public var offset: Int = 0
    private var nextOffset: Int = 0

    public weak var output: ARCHPagingManagerOutput?

    public static let defaultPageSize: Int = 40
    public static let dafaultTriggerBlock: TriggerBlock = { indexPath, nextOffset in
        indexPath.row >= nextOffset
    }

    private let debugLog: ((String) -> Void)? = {
        if let debugMode = ProcessInfo.processInfo.environment["ARCHPagingManagerDebugMode"], Int(debugMode) == 1 {
            return { print($0) }
        } else {
            return nil
        }
    }()

    /**
     @param pageSize - кол-во элементов на странице, по дефолту 40
     @param trigerBlock - клажура проверяющая можно ли загружать следующую страницу, по дефолту:
        indexPath.row >= nextOffset
     Нужно изменить для не одномерных списков, например секционных
     */
    public init(
        pageSize: Int = ARCHPagingManager.defaultPageSize,
        trigerBlock: @escaping TriggerBlock = ARCHPagingManager.dafaultTriggerBlock
        ) {
        self.pageSize = pageSize
        self.nextOffset = pageSize / 2
        self.triggerBlock = trigerBlock
        super.init()
    }

    // MARK: - ARCHPagingManagerInput

    public func willDisplayCell(indexPath: IndexPath) {
        debugLog?("[ARCHPagingManager] Will display cell by \(indexPath)")
        if triggerBlock(indexPath, nextOffset) {
            performLoadNextData()
        }
    }

    public func performLoadNextData() {
        guard !isLoading && !reachedEnd else {
            return
        }

        debugLog?("[ARCHPagingManager] performLoadNextData")
        addQueueRequest(offset: offset)
    }

    @objc
    public func performRefreshData() {
        addQueueRequest(offset: 0)
    }

    // MARK: Private

    private func addQueueRequest(offset: Int) {
        debugLog?("[ARCHPagingManager] addQueueRequest")
        isLoading = true

        DispatchQueue.main.async { [weak self] in
            self?.performRequest(offset: offset)
        }
    }

    private func performRequest(offset: Int, completion: (() -> Void)? = nil) {
        debugLog?("[ARCHPagingManager] performRequest by offset \(offset)")

        currentRequest?.cancel()
        currentRequest = output?.performRequest(offset: offset, pageSize: pageSize, completion: { [weak self] count, total in
            if let count = count, let total = total {
                self?.offset = offset + count
                self?.nextOffset = offset + count / 2
                self?.reachedEnd = offset + count >= total
            }

            self?.debugLog?("[ARCHPagingManager] end current request reachedEnd \(String(describing: self?.reachedEnd))")
            completion?()
            self?.isLoading = false
        })
    }
}
