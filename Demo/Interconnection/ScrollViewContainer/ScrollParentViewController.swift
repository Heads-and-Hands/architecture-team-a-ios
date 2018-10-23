//
//  ScrollParentViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 23/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class ScrollParentViewController: ARCHViewController<ScrollParentState, ScrollParentEventHandler>, ARCHContainer {

    // MARK: - View life cycle

    let containers: [(tag: ScrollParentEventHandler.ModuleTag, view: UIView)] = [
        (.first, UIView()),
        (.second, UIView()),
        (.third, UIView()),
        (.fourth, UIView()),
        (.fifth, UIView()),
        (.sixth, UIView()),
        (.seventh, UIView()),
        (.eighth, UIView())
    ]

    override func prepareRootView() {
        super.prepareRootView()

        view.backgroundColor = .white

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        let stackView = UIStackView(arrangedSubviews: containers.map({ $0.view }))
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(stackView)

        let closeButton = DefaultButton(title: "Close")
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(self.closeButtonTapHandler(_:)), for: .touchUpInside)

        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -8.0),

            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
            closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15.0)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Actions

    @objc
    private func closeButtonTapHandler(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - ARCHContainer

    func container(for id: UUID) -> UIView {
        guard let tag = output?.tag(for: id) else {
            return UIView()
        }
        return containers.first(where: { $0.tag == tag })?.view ?? UIView()
    }
}
