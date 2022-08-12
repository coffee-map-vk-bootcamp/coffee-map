//
//  CoffeeShopDetailScreenViewController.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import UIKit

final class CoffeeShopDetailScreenViewController: UIViewController {
    private let output: CoffeeShopDetailScreenViewOutput
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    init(output: CoffeeShopDetailScreenViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.didLoadView()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutCollectionView()
    }
}

extension CoffeeShopDetailScreenViewController: CoffeeShopDetailScreenViewInput {
}

private extension CoffeeShopDetailScreenViewController {
    func setup() {
        loadSetup()
        setupCollectionView()
    }
    
    func loadSetup() {
        view.backgroundColor = .systemBackground
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        collectionView.collectionViewLayout = layout
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CoffeeShopDetailCollectionViewCell.self)
        collectionView.register(CoffeeShopDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    func layoutCollectionView() {    
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CoffeeShopDetailScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(CoffeeShopDetailHeaderView.self,
                                                                         ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
        
        let model = output.item(at: indexPath.item)
        let imageData = output.image(at: model.headerImageURL) ?? Data()
        // MARK: DOWNLOAD
        headerView.configure(with: UIImage(data: imageData))
        headerView.configure(with: .init(named: AppImageNames.mockHeader))
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CoffeeShopDetailCollectionViewCell.self, for: indexPath)
        
        let model = output.item(at: indexPath.item)
        cell.configure(with: model, delegate: self)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.count
    }
}

extension CoffeeShopDetailScreenViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.size.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: collectionView.frame.size.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 24, left: 0, bottom: 0, right: 0)
    }
}

extension CoffeeShopDetailScreenViewController: CoffeeShopDetailCollectionDelegate {
    func didSelect(with item: Dish) {
        output.didSelectDish(with: item)
    }
}
