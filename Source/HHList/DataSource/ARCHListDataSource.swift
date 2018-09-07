//
//  ARCHListDataSource.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public protocol ARCHListDataSourceAdapter: class {
    var sectionsCount: Int { get }

    func numberOfRowsIn(section: Int) -> Int
    func cellViewModelAt(indexPath: IndexPath) -> ARCHCellViewModel
}

public protocol ARCHListDataSourceDelegate: class {
    func configure(cell: Any, viewModel: ARCHCellViewModel, indexPath: IndexPath)
}

open class ARCHListDataSource<View: ARCHListView>: NSObject {
    public var view: View

    public weak var dataAdapter: ARCHListDataSourceAdapter? {
        didSet {
            view.reloadDataSource()
        }
    }

    public weak var delegate: ARCHListDataSourceDelegate?
    public weak var dataSource: View.DataSourceType? {
        didSet {
            refreshViewDataSource()
        }
    }

    // Обновление ds сделать через функцию

    public init(view: View) {
        self.view = view
        super.init()
        refreshViewDataSource()
    }

    // MARK: - Public

    public func register(cell: View.CellType.Type, for viewModel: ARCHCellViewModel.Type) {
        view.register(cell: cell, cellID: cellID(viewModelClass: viewModel))
    }

    public var sectionsCount: Int {
        return dataAdapter?.sectionsCount ?? 0
    }

    public func numberOfRowsIn(section: Int) -> Int {
        return dataAdapter?.numberOfRowsIn(section: section) ?? 0
    }

    public func reusableCell(indexPath: IndexPath) -> View.CellType {
        guard let cellViewModel = dataAdapter?.cellViewModelAt(indexPath: indexPath) else {
            fatalError("Not found cell vm at indexPath = \(indexPath)")
        }

        let id = cellID(viewModelClass: type(of: cellViewModel))

        guard let cell = view.reusableCellWith(id: id, indexPath: indexPath) else {
            fatalError("Not found cell id \(id) indexPath \(indexPath)")
        }

        delegate?.configure(cell: cell, viewModel: cellViewModel, indexPath: indexPath)

        if var cell = cell as? ARCHCellAbstract {
            cell.abstractViewModel = cellViewModel
        }

        return cell
    }

    // MARK: - Helpers

    private func cellID(viewModelClass: ARCHCellViewModel.Type) -> String {
        return String(describing: viewModelClass)
    }

    // MARK: - Refresh Data Source

    private func refreshViewDataSource() {
        view.set(dataSource: nil)
        view.set(dataSource: self as? View.DataSourceType)
    }

    // MARK: - DataSource Proxy

    override open func responds(to aSelector: Selector!) -> Bool {
        if super.responds(to: aSelector) {
            return true
        }

        return dataSource?.responds(to: aSelector) ?? false
    }

    override open func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let dataSource = dataSource, dataSource.responds(to: aSelector) {
            return dataSource
        }

        return super.forwardingTarget(for: aSelector)
    }
}

private extension NSPointerArray {

    func addObject(_ object: AnyObject?) {
        guard let object = object else {
            return
        }

        let pointer = Unmanaged.passUnretained(object).toOpaque()
        addPointer(pointer)
    }
}
