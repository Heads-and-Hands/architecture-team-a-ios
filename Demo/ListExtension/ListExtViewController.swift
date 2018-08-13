//
//  ListExtViewController.swift
//  architecture
//
//  Created by basalaev on 10.08.2018.
//  Copyright © 2018 Heads and Hands. All rights reserved.
//

import HHModule

final class ListExtViewController: ARCHViewController<ListExtState, ListExtEventHandler> {

    let button = UIButton()
    let listController = ARCHTableViewController<ListExtItem, ListExtTVCellViewModel, ListExtTVCell>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configure(button: button)
        setupLayout()
    }

    // MARK: - Configure

    func configure(button: UIButton) {
        button.addTarget(self, action: #selector(action(sender:)), for: .touchUpInside)
        button.setTitle("Add items", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
    }

    func setupLayout() {
        let buttonHeight: CGFloat = 50

        addChildViewController(listController)
        listController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - buttonHeight)
        listController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(listController.view)
        listController.didMove(toParentViewController: self)

        button.frame = CGRect(x: 0, y: view.bounds.maxY - buttonHeight, width: view.bounds.width, height: buttonHeight)
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(button)
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        listController.data = state.list
    }

    // MARK: - Actions

    @objc
    func action(sender: UIButton) {
        output?.pressAddButton()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("Realizated in ARCHTableViewDataSource")
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section title"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
