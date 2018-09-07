//
//  ARCHCollectionViewDataSource.swift
//  architecture
//
//  Created by basalaev on 14.07.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import UIKit

open class ARCHCollectionViewDataSource: ARCHListDataSource<UICollectionView> {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionsCount
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRowsIn(section: section)
    }

    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return reusableCell(indexPath: indexPath)
    }
}

extension NSObject: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fatalError("Realizated in ARCHCollectionViewDataSource")
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("Realizated in ARCHCollectionViewDataSource")
    }
}

extension UICollectionView: ARCHListView {
    public typealias CellType = UICollectionViewCell
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

    public func reusableCellWith(id: String, indexPath: IndexPath) -> CellType? {
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
    }
}
