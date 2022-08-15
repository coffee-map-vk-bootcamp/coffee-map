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
        collectionView.collectionViewLayout = CompositionalLayout.createLayout(
            contentSize: .init(width: view.frame.size.width, height: view.frame.size.height),
            output: output)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DishCollectionViewCell.self)
        collectionView.register(CoffeeShopDetailHeaderView.self, forSupplementaryViewOfKind: Constants.HeaderKind.globalHeader)
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(DishCollectionViewCell.self, for: indexPath)
        let model = output.item(at: indexPath.section, with: indexPath.row)
        cell.configure(with: model)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.number(of: section)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(CoffeeShopDetailHeaderView.self,
                                                                     ofKind: Constants.HeaderKind.globalHeader, for: indexPath)
        
        header.configure(with: .init(named: AppImageNames.mockHeader))
        return header
    }
}

extension CoffeeShopDetailScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tempVC = UIViewController()
        tempVC.view.backgroundColor = .lightGray
        present(tempVC, animated: true)
    }
}

extension CoffeeShopDetailScreenViewController: CoffeeShopDetailCollectionDelegate {
    func didSelect(with item: Dish) {
        output.didSelectDish(with: item)
    }
}
