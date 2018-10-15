//
//  ARCHRequestsInfoViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 12/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ARCHRequestsInfoViewController: ARCHViewController<ARCHRequestsInfoState, ARCHRequestsInfoEventHandler> {

    private let requestView = ARCHStorageInfoView(title: "Request parameters")
    private let resposeView = ARCHStorageInfoView(title: "Response parameters")

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        title = "Request Info"

        let rootScrollView = UIScrollView()
        rootScrollView.showsVerticalScrollIndicator = false
        rootScrollView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            rootScrollView.contentInsetAdjustmentBehavior = .never
        }
        rootScrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(rootScrollView)

        NSLayoutConstraint.activate([
            rootScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            rootScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0)
        ])

        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                rootScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
                rootScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8.0)
            ])
        } else {
            NSLayoutConstraint.activate([
                rootScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0),
                rootScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0)
            ])
        }

        let rootStackView = UIStackView(arrangedSubviews: [requestView, resposeView])
        rootStackView.axis = .vertical
        rootStackView.spacing = 8.0
        rootStackView.translatesAutoresizingMaskIntoConstraints = false

        rootScrollView.addSubview(rootStackView)

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: rootScrollView.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: rootScrollView.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: rootScrollView.trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: rootScrollView.bottomAnchor),

            rootStackView.widthAnchor.constraint(equalTo: rootScrollView.widthAnchor)
        ])

    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        requestView.update(date: state.requestDate, values: state.requestParameters)
        resposeView.update(date: state.responseDate, values: state.responseParameters)
    }
}
