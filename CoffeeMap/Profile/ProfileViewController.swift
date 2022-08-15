//
//  ProfileViewController.swift
//  CoffeeMap
//
//  Created by Матвей Борисов on 12.08.2022.
//  
//

import UIKit

final class ProfileViewController: UIViewController {
	private let output: ProfileViewOutput

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()

    init(output: ProfileViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        setup()
        layout()
	}

    private func setup() {
        collectionView.register(ProfileCollectionViewHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: ProfileCollectionViewHeader.self))
        collectionView.register(ReceiptCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ReceiptCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionConstraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(collectionConstraints)
    }
}

// MARK: UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ReceiptCollectionViewCell.self),
                                                  for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: String(describing: ProfileCollectionViewHeader.self),
                                                                         for: indexPath)
            return header
        }
        assert(false)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.frame.width, height: 100)
    }
}

// MARK: ProfileViewInput

extension ProfileViewController: ProfileViewInput {
}
