//
//  IndicationDemoViewController.swift
//  architecture
//
//  Created by basalaev on 30.08.2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule
import HHListExtension
import HHIndication

enum ActionType: Int {
    case load = 0
    case data
    case empty
    case error

    static var allValues: [ActionType] {
        return [.load, .data, .empty, .error]
    }

    static var allTitles: [String] {
        return allValues.map { $0.title }
    }

    var title: String {
        switch self {
        case .load:
            return "Загрузка"
        case .data:
            return "Список"
        case .empty:
            return "Нет данных"
        case .error:
            return "Ошибка"
        }
    }
}

final class IndicationDemoViewController: ARCHViewController<IndicationDemoState, IndicationDemoEventHandler>, ARCHIndicationContainer {

    let segmentControll = UISegmentedControl(items: ActionType.allTitles)

    let listController = ARCHTableViewController<SimpleEntity, ExampleCellViewModel, ExampleCell>()
    let indicationHelper = IndicationHelper()

    override func prepareRootView() {
        super.prepareRootView()

        indicationHelper.container = self
        layoutIndicationGuide.topConstraint?.constant = 64

        view.backgroundColor = .white

        configure(segmentControl: segmentControll)
        setupLayout()
    }

    // MARK: - Configure

    func configure(segmentControl: UISegmentedControl) {
        segmentControl.backgroundColor = .white
        segmentControl.addTarget(self, action: #selector(action(sender:)), for: .valueChanged)
    }

    func setupLayout() {
        segmentControll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentControll)

        let tableView = listController.tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            segmentControll.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            segmentControll.leftAnchor.constraint(equalTo: view.leftAnchor),
            segmentControll.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: segmentControll.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Actions

    @objc
    func action(sender: UISegmentedControl) {
        guard let actionType = ActionType(rawValue: sender.selectedSegmentIndex) else {
            return
        }

        switch actionType {
        case .load:
            output?.startLoading()
        case .data:
            output?.finishLoadingWithSomeData()
        case .empty:
            output?.finishLoadingWithEmptyData()
        case .error:
            output?.finishLoadingWithError()
        }
    }
}
