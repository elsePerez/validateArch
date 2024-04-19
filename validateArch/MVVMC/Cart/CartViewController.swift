//
//  CartViewController.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import UIKit
import NatDS

class CartViewController: UIViewController {
    
    private lazy var mainView = CartView()
    
    private let viewModel: CartViewModel
    
    init(vm: CartViewModel) {
        self.viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        setupTableView()
        registerCell()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func linkCombine() {
        viewModel.$items
            .sink { [weak self] _ in
                self?.mainView.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
    
    func setupButtons() {
        mainView.addButton.addTarget(self, action: #selector(addItem), for: .touchUpInside)
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    func registerCell() {
        let nib = UINib(nibName: "listItem", bundle: nil)
        mainView.tableView.register(nib, forCellReuseIdentifier: "listItem")
    }
    
    @objc func addItem() {
        let item = CartItem(name: "Item", price: 100)
        viewModel.addItem(item: item)
    }
    
}

extension CartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! CartItemCell
        
        cell.configure(divider: .inset)
        cell.configure(feedbackStyle: .ripple)
        cell.configure(onClick: false)
        
        cell.setup(title: viewModel.getItemTitle(index: indexPath.row), price: viewModel.getItemPrice(index: indexPath.row))
        
        return cell
    }
    
}
