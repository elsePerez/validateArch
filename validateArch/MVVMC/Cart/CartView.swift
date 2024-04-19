//
//  CArtView.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import UIKit
import NatDS
import NatDSIcons

class CartView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupConstraints()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .heading4)
        label.text = "Cart"
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body1)
        return label
    }()
    
    lazy var itemTextField: NatField = {
        let textField = NatField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Item"
        return textField
    }()
    
//    lazy var addButton: NatButton = {
//        let button = NatButton(style: .contained, size: .medium, theme: .consultoriaDeBelezaLight, color: .primary)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.configure(title: "Add Item")
//        return button
//    }()
    
    lazy var addButton: NatIconButton = {
        let button = NatIconButton(style: .standardDefault)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configure(icon: NatDSIcons.getIcon(.filledActionAdd))
        button.configure(state: .enabled)
        button.configure(background: .float)
        return button
    }()
    
    lazy var panel: ExpansionPanel = {
        let panel = ExpansionPanel()
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.setSubtitle("Lista de itens")
        return panel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(title)
        scrollView.addSubview(countLabel)
        scrollView.addSubview(itemTextField)
        scrollView.addSubview(addButton)
        scrollView.addSubview(panel)
        
        panel.setDetailView(tableView)
        
        let panelHeightConstraint = panel.heightAnchor.constraint(equalToConstant: 56)
        panelHeightConstraint.isActive = true
        
        panel.setCustomAnimationForExpand {
            UIView.animate(withDuration: 0.3) {
                panelHeightConstraint.constant = 250
                self.layoutIfNeeded()
            }
        }
        panel.setCustomAnimationForCollapse {
            UIView.animate(withDuration: 0.3) {
                panelHeightConstraint.constant = 56
                self.layoutIfNeeded()
            }
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            title.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 32),
            title.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            countLabel.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 32),
            countLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            itemTextField.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 32),
            itemTextField.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            addButton.topAnchor.constraint(equalTo: itemTextField.bottomAnchor, constant: 32),
            
            panel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 32),
            panel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            tableView.widthAnchor.constraint(equalTo: panel.widthAnchor),
//            tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
        
    }
    
}
