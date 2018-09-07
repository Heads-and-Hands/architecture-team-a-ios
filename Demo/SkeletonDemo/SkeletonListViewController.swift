//
//  SkeletonListViewController.swift
//  architecture
//
//  Created by basalaev on 28.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHList

final class SkeletonListViewController: ARCHViewController<SkeletonListState, SkeletonListEventHandler>, ARCHIndicationContainer {

    let tableView = UITableView()
    let button = UIButton()
    let indicationManager = ARCHIndicationHelper<Int>()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        indicationManager.container = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var dataSource: ARCHTableViewDataSource = {
        let dataSource = ARCHTableViewDataSource(view: tableView)
        dataSource.register(cell: ExampleCell.self, for: ExampleCellViewModel.self)
        dataSource.dataAdapter = dataAdapter
        return dataSource
    }()

    lazy var dataAdapter = ARCHEmptyListDataAdapter<SimpleEntity, ExampleCellViewModel>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configure(tableView: tableView)
        configure(button: button)
        setupLayout()
    }

    // MARK: - Configure

    func configure(tableView: UITableView) {
        tableView.dataSource = dataSource
    }

    func configure(button: UIButton) {
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        button.setTitle("Add items", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
    }

    func setupLayout() {
        let buttonHeight: CGFloat = 50

        tableView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonHeight)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(tableView)

        button.frame = CGRect(x: 0, y: view.bounds.maxY - buttonHeight, width: view.bounds.width, height: buttonHeight)
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(button)
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        print("render")

        dataAdapter.data = state.list
        tableView.reloadData()
    }

    // MARK: - Actions

    @objc
    func action(sender: UIButton) {
        output?.pressAddButton()
    }
}
