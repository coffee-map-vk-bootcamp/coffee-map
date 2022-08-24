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
    private var headerOutput: CartListFooterDescription?
    
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
        navigationItem.title = "Корзина"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        tableView.reloadData()
        footerView.configure(sumPrice: output.price)
    }
    
    private func setup(){
        view.backgroundColor = .appTintColor
        view.addSubviews([tableView, footerView])
        tableView.sectionHeaderTopPadding = 0.0
        tableView.register(CartScreenCell.self, forCellReuseIdentifier: CartScreenCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.register(CartListHeader.self, forHeaderFooterViewReuseIdentifier: CartListHeader.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        footerView.delegate = self
        headerOutput = footerView
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CartScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.dishList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartScreenCell.reuseIdentifier,
                                                       for: indexPath) as? CartScreenCell else { return UITableViewCell() }
        let dish = output.dishList[indexPath.row]
        cell.configure(image: dish.image, name: dish.name, price: String(dish.price), count: String(dish.count))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CartListHeader.reuseIdentifier)
                as? CartListHeader else { return UIView() }
        header.configure(name: output.coffeeShopName)
        return header
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.performBatchUpdates { [weak self] in
                self?.output.deleteDishFromOrder(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .top)
            } completion: { [weak self] _ in
                self?.tableView.reloadData()
                self?.footerView.configure(sumPrice: self?.output.price ?? 0)
            }

        }
    }
}

extension CartScreenViewController: CartListFooterDelegate {
    func makeOrderDidTap() {
        guard let time = headerOutput?.orderTime else {
            return
        }
        output.makeOrder(time: time) { [weak self] result in
            switch result {
            case .success(_):
                let alert = UIAlertController(title: "", message: "Заказ успешно оплачен", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Закрыть", style: .default)

                alert.addAction(alertAction)
                self?.tableView.reloadData()
                self?.footerView.configure(sumPrice: self?.output.price ?? 0)
                self?.present(alert, animated: true)
            case .failure(_):
                let alert = UIAlertController(title: "", message: "Ошбика при создании заказа", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Попробовать позже", style: .default)

                alert.addAction(alertAction)
                self?.present(alert, animated: true)
            }
        }
    }
}

extension CartScreenViewController: CartScreenViewInput {
}
