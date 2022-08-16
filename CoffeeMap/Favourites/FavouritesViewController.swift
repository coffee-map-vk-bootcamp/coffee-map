//
//  FavouritesViewController.swift
//  CoffeeMap
//
//  Created by Иван Сурганов on 15.08.2022.
//

import UIKit

final class FavouritesViewController: UIViewController {
    private let output: FavouritesViewOutput
    private let refreshControl = UIRefreshControl()
    
    var favouriteCoffeeShops: [FavouritesPresenter.FavouriteCoffeeShop] = [FavouritesPresenter.FavouriteCoffeeShop(name: "БебраКофе",
                                                address: "Москва, Тверская 224"),
        FavouritesPresenter.FavouriteCoffeeShop(name: "ОлегКофе",
                                                address: "Москва, Тверская 4"),
        FavouritesPresenter.FavouriteCoffeeShop(name: "БобКофе",
                                                address: "Москва, Тверская 24"),
        FavouritesPresenter.FavouriteCoffeeShop(name: "ТиматиКофе",
                                                address: "Москва, Тверская 2"),
        FavouritesPresenter.FavouriteCoffeeShop(name: "ЛолКофе",
                                                address: "Москва, Тверская 11")]
    
    private lazy var favouritesCollectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = true
        collection.bounces = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FavouritesCell.self, forCellWithReuseIdentifier: FavouritesCell.reuseIdentifire)
        return collection
    }()
    
    init(output: FavouritesViewOutput) {
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
        setupCollectionView()
        setupRefresher()
    }
}

extension FavouritesViewController: FavouritesViewInput {
    func reloadData() {
        favouritesCollectionView.reloadData()
    }
}

private extension FavouritesViewController {
    
    func setupCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        favouritesCollectionView.collectionViewLayout = flowLayout
        
        favouritesCollectionView.delegate = self
        favouritesCollectionView.dataSource = self
    }
    
    func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Избранные"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    func setupRefresher() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        favouritesCollectionView.alwaysBounceVertical = true
        favouritesCollectionView.refreshControl = refreshControl
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        // Do you your api calls in here, and then asynchronously remember to stop the
        // refreshing when you've got a result (either positive or negative)
        refreshControl.endRefreshing()
    }
    
    func layout() {
        view.addSubview(favouritesCollectionView)
        NSLayoutConstraint.activate([
            favouritesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favouritesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favouritesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favouritesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension FavouritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteCoffeeShops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouritesCell.reuseIdentifire, for: indexPath) as? FavouritesCell
        else { return UICollectionViewCell() }
        let shop = favouriteCoffeeShops[indexPath.row]
        cell.configure(with: shop)
        
        return cell
    }
}

extension FavouritesViewController: UICollectionViewDelegate {
    
}

extension FavouritesViewController: UICollectionViewDelegateFlowLayout {
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

extension UICollectionViewCell {
    
    static var reuseIdentifire: String {
        return NSStringFromClass(self)
    }
}
