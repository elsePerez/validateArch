//
//  AddProductFormView.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import UIKit
import NatDS

class AddProductFormView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var productDescripionTextField: TextField = {
        let field = TextField()
        field.configure(title: "Código")
        field.configure(placeholder: "1234")
        field.configure(type: .text)
        field.configure(size: .medium)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var productQuantityTextField: TextField = {
        let field = TextField()
        field.configure(title: "Quantidade")
        field.configure(placeholder: "10")
        field.configure(type: .number)
        field.configure(size: .medium)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var addProductButton: NatButton = {
        let button = NatButton(style: .contained, size: .medium, theme: .consultoriaDeBelezaLight, color: .primary)
        button.configure(title: "Adicionar")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var loading: NatProgressIndicatorCircular = {
        let indicator = NatProgressIndicatorCircular(size: .medium, backgroundLayer: true, theme: .consultoriaDeBelezaLight)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    func setup() {
        formStackView.addArrangedSubview(productDescripionTextField)
        formStackView.addArrangedSubview(productQuantityTextField)
        
        buttonStackView.addArrangedSubview(addProductButton)
        buttonStackView.addArrangedSubview(loading)
        
        self.addSubview(formStackView)
        self.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: self.topAnchor),
            formStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: NatSizes.standard),
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

}
