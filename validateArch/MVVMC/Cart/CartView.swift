//
//  CArtView.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import UIKit
import NatDS

class CartView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    var title: UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .heading4)
        return label
    }
    
    var itemTextField: NatField {
        let textField = NatField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Item"
        return textField
    }
    
    var addButton: NatButton {
        let button = NatButton(style: .contained, size: .medium, theme: .consultoriaDeBelezaLight, color: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configure(title: "Add Item")
        return button
    }
    
    var tableView: UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(title)
        scrollView.addSubview(itemTextField)
        scrollView.addSubview(addButton)
        scrollView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            title.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            title.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            
            itemTextField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            itemTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            
            addButton.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 32),
            addButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            
            tableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
}
