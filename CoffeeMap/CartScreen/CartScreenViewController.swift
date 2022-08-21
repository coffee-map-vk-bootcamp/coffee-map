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
    private var sumCount: Int = 0 {
        didSet {
            footerView.configure(sumPrice: sumCount)
        }
    }
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup(){
        view.addSubviews([tableView, footerView])
        tableView.register(CartScreenCell.self, forCellReuseIdentifier: CartScreenCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.register(CartListHeader.self, forHeaderFooterViewReuseIdentifier: CartListHeader.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartScreenCell.reuseIdentifier, for: indexPath) as? CartScreenCell else { return UITableViewCell() }
        let dish = output.getOrder().dishes[indexPath.row]
        sumCount = sumCount + dish.price * dish.count
        cell.configure(image: dish.image, name: dish.name, price: String(dish.price), count: String(dish.count))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CartListHeader.reuseIdentifier) as? CartListHeader else { return UIView() }
        header.configure(name: output.getOrder().coffeeShop)
        return header
    }
}

extension CartScreenViewController: CartScreenViewInput {
}
