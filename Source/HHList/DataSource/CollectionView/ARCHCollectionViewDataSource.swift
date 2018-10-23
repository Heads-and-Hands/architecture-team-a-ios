//
//  ARCHCollectionViewDataSource.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHCollectionViewDataSource: ARCHListDataSource<UICollectionView>, UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsCount
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRowsIn(section: section)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return reusableCell(indexPath: indexPath)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
        ) -> UICollectionReusableView {

        let view: UICollectionReusableView?

        if kind == UICollectionView.elementKindSectionHeader {
            view = reusableHeader(indexPath: indexPath)
        } else if kind == UICollectionView.elementKindSectionFooter {
            view = reusableFooter(indexPath: indexPath)
        } else {
            fatalError("Used not supported reusable view kind \(kind)")
        }

        if let view = view {
            return view
        } else {
            fatalError("Not found reusable view for kind \(kind) at indexPath \(indexPath)")
        }
    }
}

extension UICollectionView: ARCHListView {
    public typealias CellType = UICollectionViewCell
    public typealias HeaderFooterType = UICollectionReusableView
    public typealias DataSourceType = UICollectionViewDataSource

    public func reloadDataSource() {
        reloadData()
    }

    public func set(dataSource: DataSourceType?) {
        self.dataSource = dataSource
    }

    public func register(cell: CellType.Type, cellID: String) {
        let bundle = Bundle(for: cell)
        let nibName = String(describing: cell)

        if bundle.path(forResource: nibName, ofType: "nib") == nil {
            register(cell, forCellWithReuseIdentifier: cellID)
        } else {
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: cellID)
        }
    }

    public func register(header: HeaderFooterType.Type, headerID: String) {
        register(reusableView: header, kind: UICollectionView.elementKindSectionHeader, viewID: headerID)
    }

    public func register(footer: HeaderFooterType.Type, footerID: String) {
        register(reusableView: footer, kind: UICollectionView.elementKindSectionFooter, viewID: footerID)
    }

    public func reusableCellWith(id: String, indexPath: IndexPath) -> CellType? {
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
    }

    public func reusableHeaderWith(id: String, indexPath: IndexPath) -> HeaderFooterType? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: id, for: indexPath)
    }

    public func reusableFooterWith(id: String, indexPath: IndexPath) -> HeaderFooterType? {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: id, for: indexPath)
    }

    // MARK: - Private

    func register(reusableView: HeaderFooterType.Type, kind: String, viewID: String) {
        let bundle = Bundle(for: reusableView)
        let nibName = String(describing: reusableView)

        if bundle.path(forResource: nibName, ofType: "nib") == nil {
            register(reusableView, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewID)
        } else {
            let nib = UINib(nibName: nibName, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewID)
        }
    }
}
