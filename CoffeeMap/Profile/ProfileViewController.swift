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
    
    private let tableView = UITableView()
    
    private var header: ProfileTableViewHeader?
    
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
        output.loadUser()
    }
    
    private func setup() {
        view.backgroundColor = .appTintColor
        tableView.register(ProfileTableViewHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableViewHeader.self))
        tableView.register(ReceiptCollectionViewCell.self, forCellReuseIdentifier: String(describing: ReceiptCollectionViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReceiptCollectionViewCell.self))
                as? ReceiptCollectionViewCell else {
            return UITableViewCell()
        }
        let model = output.prepare(data: output.item(at: indexPath.row))
        cell.configure(with: model)
        return cell
    }
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableViewHeader.self))
        header = tableViewHeader as? ProfileTableViewHeader
        header?.output = self
        return tableViewHeader
    }
}

// MARK: ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    func didLoad(user: User) {
        header?.configure(with: user)
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ProfileViewController: ProfileHeaderOutput {
    func logout() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Вы дейстивельно хотите выйти?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { [weak self] _ -> Void in
            self?.output.logout()
        }
        ))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
