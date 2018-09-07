//
//  CustomAnimationMainViewController.swift
//  architecture
//
//  Created by Eugene Sorokin on 06/09/2018.
//  Copyright © 2018 HandH. All rights reserved.
//

import HHList
import HHModule
import UIKit

final class CustomAnimationMainViewController<Out: CustomAnimationMainViewOutput>: ARCHViewController<CustomAnimationMainState, Out> {

    let pushButton = CustomButton(title: "PUSH")
    let presentButton = CustomButton(title: "PRESENT")
    let stackView = UIStackView()

    var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        pushButton.addTarget(self, action: #selector(self.pushButtonDidTap(_:)), for: .touchUpInside)
        presentButton.addTarget(self, action: #selector(self.presentButtonDidTap(_:)), for: .touchUpInside)

        [pushButton, presentButton].forEach({
            self.stackView.addArrangedSubview($0)
        })

        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            stackView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor)
        ])
    }

    override func render(state: State) {
        super.render(state: state)
    }

    // MARK: - Configuration

    private func configureCollectionView() {

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: CustomAnimatorCell.self, cellID: CustomAnimatorCell.reuseID)

    }

    // MARK: - Actions

    @objc
    private func pushButtonDidTap(_ sender: UIButton) {
        output?.didTapPushButton()
    }

    @objc
    private func presentButtonDidTap(_ sender: UIButton) {
        output?.didTapPresentButton()
    }

    // MARK: - UICollectionViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomAnimatorCell.reuseID, for: indexPath)

        if let cell = cell as? CustomAnimatorCell {
            cell.render()
        }

        return cell
    }
}

class CustomButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .blue
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 32.0)

        layer.cornerRadius = 15.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomAnimatorCell: UICollectionViewCell {

    static let reuseID = "CustomAnimatorCell"

    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render() {
        guard let url = URL(string: "https://placeimg.com/640/480/any") else {
            return
        }

        URLSession(configuration: .default).dataTask(
            with: url,
            completionHandler: {[weak self] data, url, error in
                guard let `self` = self else {
                    return
                }

                if let error = error {
                    print("LOG DEBUG: \(error.localizedDescription)")
                } else if let imageData = data {
                    self.imageView.image = UIImage(data: imageData)
                } else {
                    print("LOG DEBUG: Could not load image")
                }
        })
    }
}
