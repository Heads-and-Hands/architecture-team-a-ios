//
//  PaginationViewController.swift
//  architecture
//
//  Created by basalaev on 20.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule
import HHListExtension
import HHPagingManager

final class PaginationViewController: ARCHViewController<PaginationState, PaginationEventHandler>, UITableViewDelegate {

    let listController = ARCHTableViewController<SimpleEntity, ExampleCellViewModel, ExampleCell>()
    var pagingManager: ARCHTableViewPagingManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        pagingManager?.delegate = self
        listController.tableView.delegate = pagingManager

        setupLayout()

        pagingManager?.performLoadNextData()
    }

    // MARK: - Configure

    func setupLayout() {
        addChildViewController(listController)
        listController.view.frame = view.bounds
        listController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(listController.view)
        listController.didMove(toParentViewController: self)
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        listController.data = state.list
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay indexPath \(indexPath.row)")
    }
}
