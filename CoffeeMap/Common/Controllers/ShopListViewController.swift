//
//  ShopListViewController.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 17.08.2022.
//

import UIKit
import CoreLocation
import MapKit

protocol ShopListViewControllerDelegate: AnyObject {
    func getCoffeeShops()
    func remove(at index: Int)
    func refresh()
}

class ShopListViewController: UIViewController {
    weak var delegate: ShopListViewControllerDelegate?
    private let refreshControl = UIRefreshControl()
    
    private var favouriteCoffeeShops = [CoffeeShop]()
    
    private lazy var favouritesCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FavouritesCell.self, forCellWithReuseIdentifier: FavouritesCell.reuseIdentifier)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        layout()
        setupCollectionView()
        setupRefresher()
        getCoffeeShops()
    }
    
    func configure(with shops: [CoffeeShop]) {
        favouriteCoffeeShops = shops
        self.favouritesCollectionView.performBatchUpdates({
            let indexSet = IndexSet(integer: 0)
            self.favouritesCollectionView.reloadSections(indexSet)
        }, completion: nil)
    }
}

private extension ShopListViewController {
    
    func getCoffeeShops() {
        delegate?.getCoffeeShops()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        favouritesCollectionView.collectionViewLayout = flowLayout
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
    }
    
    func setup() {
        view.backgroundColor = .white
    }
    
    func setupRefresher() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        favouritesCollectionView.alwaysBounceVertical = true
        favouritesCollectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        delegate?.refresh()
        refreshControl.endRefreshing()
    }
    
    func setupViews() {
        view.addSubview(favouritesCollectionView)
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            favouritesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouritesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favouritesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favouritesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ShopListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteCoffeeShops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCell.reuseIdentifier, for: indexPath) as? FavouritesCell
        else { return UICollectionViewCell() }
        let shop = favouriteCoffeeShops[indexPath.row]
        cell.delegate = self
        cell.configure(with: shop, index: indexPath.item)
        
        return cell
    }
}

extension ShopListViewController: UICollectionViewDelegate {
    
}

extension ShopListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width - 32, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ShopListViewController: FavouriteCellDelegate {    
    func remove(at index: Int) {
        delegate?.remove(at: index)
    }
}
