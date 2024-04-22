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
    
    lazy var formView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        scrollView.addSubview(formView)
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
            
            formView.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 32),
            formView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            formView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            panel.topAnchor.constraint(equalTo: formView.bottomAnchor, constant: 32),
            panel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
//            tableView.widthAnchor.constraint(equalTo: panel.widthAnchor),
//            tableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 400)
        ])
        
    }
    
}
