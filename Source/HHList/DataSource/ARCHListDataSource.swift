//
//  ARCHListDataSource.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

public protocol ARCHListDataSourceDelegate: class {
    func configure(cell: Any, viewModel: ARCHCellViewModel, indexPath: IndexPath)
    func configure(header: Any, viewModel: ARCHHeaderFooterViewModel, indexPath: IndexPath)
    func configure(footer: Any, viewModel: ARCHHeaderFooterViewModel, indexPath: IndexPath)
}

public extension ARCHListDataSourceDelegate {
    func configure(header: Any, viewModel: ARCHHeaderFooterViewModel, indexPath: IndexPath) {}
    func configure(footer: Any, viewModel: ARCHHeaderFooterViewModel, indexPath: IndexPath) {}
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

    public func register(header: View.HeaderFooterType.Type, for viewModel: ARCHHeaderFooterViewModel.Type) {
        view.register(header: header, headerID: headerFooterID(viewModelClass: viewModel))
    }

    public func register(footer: View.HeaderFooterType.Type, for viewModel: ARCHHeaderFooterViewModel.Type) {
        view.register(footer: footer, footerID: headerFooterID(viewModelClass: viewModel))
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

    public func reusableHeader(indexPath: IndexPath) -> View.HeaderFooterType? {
        guard let headerViewModel = dataAdapter?.headerViewModelAt(indexPath: indexPath) else {
            return nil
        }

        let id = headerFooterID(viewModelClass: type(of: headerViewModel))

        guard let view = view.reusableHeaderWith(id: id, indexPath: indexPath) else {
            fatalError("Not found header view id \(id) indexPath \(indexPath)")
        }

        delegate?.configure(header: view, viewModel: headerViewModel, indexPath: indexPath)

        if var headerView = view as? ARCHHeaderFooterViewAbstract {
            headerView.abstractViewModel = headerViewModel
        }

        return view
    }

    public func reusableFooter(indexPath: IndexPath) -> View.HeaderFooterType? {
        guard let footerViewModel = dataAdapter?.footerViewModelAt(indexPath: indexPath) else {
            return nil
        }

        let id = headerFooterID(viewModelClass: type(of: footerViewModel))

        guard let view = view.reusableFooterWith(id: id, indexPath: indexPath) else {
            fatalError("Not found header view id \(id) indexPath \(indexPath)")
        }

        delegate?.configure(footer: view, viewModel: footerViewModel, indexPath: indexPath)

        if var footerView = view as? ARCHHeaderFooterViewAbstract {
            footerView.abstractViewModel = footerViewModel
        }

        return view
    }

    // MARK: - Helpers

    private func cellID(viewModelClass: ARCHCellViewModel.Type) -> String {
        return String(describing: viewModelClass)
    }

    private func headerFooterID(viewModelClass: ARCHHeaderFooterViewModel.Type) -> String {
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
