//
//  CoffeeShopDetailScreenViewController.swift
//  CoffeeMap
//
//  Created by Vladimir Gusev on 11.08.2022.
//  
//

import UIKit
import UBottomSheet

final class CoffeeShopDetailScreenViewController: UIViewController {
    var sheetCoordinator: UBottomSheetCoordinator?
    
    private let output: CoffeeShopDetailScreenViewOutput
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.startTracking(item: self)
    }
}

extension CoffeeShopDetailScreenViewController: CoffeeShopDetailScreenViewInput {
}

private extension CoffeeShopDetailScreenViewController {
    func setup() {
        loadSetup()
        setupCollectionView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
    }
    
    func loadSetup() {
        view.backgroundColor = .systemBackground
    }
    
    func setupCollectionView() {
        collectionView.collectionViewLayout = createLayout(
            contentSize: .init(width: view.frame.size.width, height: view.frame.size.height),
            output: output)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DishCollectionViewCell.self)
        collectionView.register(SectionTitleHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        collectionView.register(CoffeeShopDetailHeaderView.self, forSupplementaryViewOfKind: Constants.HeaderKind.globalHeader)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        view.addSubview(collectionView)
    }
    
    func createLayout(contentSize: CGSize,
                      output: CoffeeShopDetailScreenViewOutput,
                      interItemSpacing: CGFloat = 16) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionNumber, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil}
            let numberOfItems = output.number(of: sectionNumber)
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .absolute(contentSize.width / 4), heightDimension: .absolute(165)))
            
            let cellWidth = CGFloat(numberOfItems * 100 + (numberOfItems - 1)) * interItemSpacing
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(cellWidth), heightDimension: .estimated(165))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .some(.fixed(8))
            
            let section = NSCollectionLayoutSection(group: group)
            
            let headerElement = self.supplementary()
            
            section.boundarySupplementaryItems = [headerElement]
            section.supplementariesFollowContentInsets = false
            
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = interItemSpacing
            section.contentInsets = .init(top: 0, leading: 24, bottom: 0, trailing: 24)
            
            return section
        }

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .absolute(150))
        
        let globalHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: Constants.HeaderKind.globalHeader, alignment: .top)
        globalHeader.contentInsets = .init(top: 0, leading: 0, bottom: 24, trailing: 0)
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        config.boundarySupplementaryItems = [globalHeader]
        
        layout.configuration = config
        
        return layout
    }
    
    func supplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return headerElement
    }
    
    func layoutCollectionView() {    
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                SectionTitleHeaderReusableView.self, ofKind: UICollectionView.elementKindSectionHeader, for: indexPath)
            let headerName = output.item(at: indexPath.section).sectionTitle
            header.configure(with: headerName)
            return header
        } else if kind == Constants.HeaderKind.globalHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                CoffeeShopDetailHeaderView.self, ofKind: Constants.HeaderKind.globalHeader, for: indexPath)
            let coffeeShop = output.getCoffeeShop()
            header.configure(with: coffeeShop)
            return header
        } else {
            fatalError()
        }
        
    }
}

extension CoffeeShopDetailScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CoffeeShopDetailScreenViewController: Draggable {
    func draggableView() -> UIScrollView? {
        return collectionView
    }
}
