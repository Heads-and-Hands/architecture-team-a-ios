//
//  PreferencesViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 16/10/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHModule

final class PreferencesViewController: ARCHViewController<PreferencesState, PreferencesEventHandler> {

    private var stackView = UIStackView()

    // MARK: - View life cycle

    override func prepareRootView() {
        super.prepareRootView()

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    // MARK: - Render

    override func render(state: State) {
        super.render(state: state)

        state.preferences.forEach({ preference in
            view(for: preference).update(preference: preference)
        })
    }

    // MARK: - Private

    private func view(for preference: Preference) -> RowView {
        if let view = stackView.arrangedSubviews.compactMap({ $0 as? RowView })
            .first(where: { $0.name == preference.name }) {
            return view
        }

        let view = RowView(frame: .zero)
        stackView.addArrangedSubview(view)
        return view
    }
}
