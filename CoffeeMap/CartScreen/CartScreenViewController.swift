//
//  CartScreenViewController.swift
//  CoffeeMap
//
//  Created by Дмитрий Голубев on 20.08.2022.
//  
//

import UIKit

final class CartScreenViewController: UIViewController {
    private let output: CartScreenViewOutput
    
    private lazy var footerView: CartListFooter = {
        let footerView = CartListFooter()
        footerView.toAutoLayout()
        
        return footerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.toAutoLayout()
        
        return tableView
    }()

    init(output: CartScreenViewOutput) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        tableView.reloadData()
        footerView.configure(sumPrice: output.price)
    }
    
    private func setup(){
        view.addSubviews([tableView, footerView])
        tableView.register(CartScreenCell.self, forCellReuseIdentifier: CartScreenCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.register(CartListHeader.self, forHeaderFooterViewReuseIdentifier: CartListHeader.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
}

extension CartScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.dishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartScreenCell.reuseIdentifier, for: indexPath) as? CartScreenCell else { return UITableViewCell() }
        let dish = output.dishList[indexPath.row]
        cell.configure(image: dish.image, name: dish.name, price: String(dish.price), count: String(dish.count)) { [weak self] in
            tableView.performBatchUpdates {
                self?.output.deleteDishFromOrder(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
            } completion: { _ in
                tableView.reloadData()
                self?.footerView.configure(sumPrice: self?.output.price ?? 0)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CartListHeader.reuseIdentifier) as? CartListHeader else { return UIView() }
        header.configure(name: output.coffeeShopName)
        return header
    }
    
}

extension CartScreenViewController: CartScreenViewInput {
}

