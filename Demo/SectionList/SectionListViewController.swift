//
//  SectionListViewController.swift
//  architecture
//
//  Created by basalaev on 14/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class SectionListViewController: ARCHViewController<SectionListState, SectionListEventHandler> {

    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())

    lazy var dataSource: ARCHCollectionViewDataSource = {
        let dataSource = ARCHCollectionViewDataSource(view: collectionView)
        dataSource.register(cell: Example2CVCell.self, for: Example2CVCellViewModel.self)
        dataSource.dataAdapter = output
        return dataSource
    }()

    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configure(collectionView: collectionView)
        configure(button: button)
        setupLayout()
    }

    // MARK: - Configure

    func configure(collectionView: UICollectionView) {
        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
    }

    func configure(button: UIButton) {
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        button.setTitle("Add items", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
    }

    func setupLayout() {
        let buttonHeight: CGFloat = 50

        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonHeight)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)

        button.frame = CGRect(x: 0, y: view.bounds.maxY - buttonHeight, width: view.bounds.width, height: buttonHeight)
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(button)
    }

    // MARK: - Render

    override func render(state: ViewState) {
        super.render(state: state)

        collectionView.reloadData()
    }

    // MARK: - Actions

    @objc
    func action(sender: UIButton) {
        output?.pressAddButton()
    }
}
