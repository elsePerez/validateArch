//
//  TableViewCell.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import UIKit
import NatDS

class CartItemCell: NatListItemCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(title: String, price: String) {
        self.title.text = title
        self.price.text = price
    }
    
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body1)
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = NatFonts.font(ofSize: .body2)
        return label
    }()
    
    private func setupConstraints() {
        self.addSubview(title)
        self.addSubview(price)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            price.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            price.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            price.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
}
