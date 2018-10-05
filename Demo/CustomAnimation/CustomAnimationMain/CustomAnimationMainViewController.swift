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

final class CustomAnimationMainViewController<Out: CustomAnimationMainViewOutput>: ARCHViewController<CustomAnimationMainState, Out>, UICollectionViewDelegateFlowLayout {

    let pushButton = CustomButton(title: "PUSH")
    let presentButton = CustomButton(title: "PRESENT")
    let stackView = UIStackView()

    var currentImage: UIImage?
    var currentFrame: CGRect?

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    lazy var dataSource: ARCHCollectionViewDataSource = {
        let dataSource = ARCHCollectionViewDataSource(view: collectionView)
        dataSource.register(cell: CustomAnimatorCell.self, for: CustomAnimatorCellViewModel.self)
        dataSource.dataAdapter = dataAdapter
        return dataSource
    }()

    lazy var dataAdapter = ARCHEmptyListDataAdapter<UIImage, CustomAnimatorCellViewModel>()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        pushButton.addTarget(self, action: #selector(self.pushButtonDidTap(_:)), for: .touchUpInside)
        presentButton.addTarget(self, action: #selector(self.presentButtonDidTap(_:)), for: .touchUpInside)

        [pushButton, presentButton].forEach({
            self.stackView.addArrangedSubview($0)
        })

        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0)
        ])

        collectionView.backgroundColor = .white
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0.0
            flowLayout.minimumInteritemSpacing = 0.0
        }

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.bringSubviewToFront(stackView)
    }

    override func render(state: State) {
        super.render(state: state)

        dataAdapter.data = state.images
        collectionView.reloadData()
    }

    // MARK: - Configuration

    private func configureCollectionView() {

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(cell: CustomAnimatorCell.self, cellID: CustomAnimatorCell.reuseID)

    }

    // ARCHTransitionAnimatorDelegate

    override func getContextData() -> Any? {
        return (currentImage, currentFrame)
    }

    // MARK: - Actions

    @objc
    private func pushButtonDidTap(_ sender: UIButton) {
        guard let image = currentImage else {
            return
        }
        output?.didTapPushButton(image)
    }

    @objc
    private func presentButtonDidTap(_ sender: UIButton) {
        guard let image = currentImage else {
            return
        }
        output?.didTapPresentButton(image)
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let columnsCount: CGFloat = 3.0

        let width: CGFloat = (collectionView.frame.width
            - flowLayout.minimumInteritemSpacing * (columnsCount - 1)
            - flowLayout.sectionInset.left
            - flowLayout.sectionInset.right)
            / columnsCount

        let height: CGFloat = width * 4.0 / 3.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let image = (dataAdapter.cellViewModelAt(indexPath: indexPath) as? CustomAnimatorCellViewModel)?.image  else {
            return
        }

        currentImage = image

        currentFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame
        currentFrame = collectionView.convert(currentFrame ?? .zero, to: collectionView.superview)
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

class CustomAnimatorCell: UICollectionViewCell, ARCHCell {

    var viewModel: CustomAnimatorCellViewModel?

    static let reuseID = "CustomAnimatorCell"

    let imageView = UIImageView()
    let foregroundView = UIView()

    override var isSelected: Bool {
        didSet {
            foregroundView.alpha = isSelected ? 1.0 : 0.0
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        foregroundView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.alpha = 0.0

        contentView.addSubview(foregroundView)

        NSLayoutConstraint.activate([
            foregroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            foregroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foregroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foregroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        imageView.image = nil
    }

    func render(viewModel: CustomAnimatorCellViewModel) {
        imageView.image = viewModel.image
    }
}

class CustomAnimatorCellViewModel: ARCHCellViewModel, ARCHModelInitilizable {
    typealias Data = UIImage

    var image: UIImage

    required init(data: Data) {
        self.image = data
    }
}
