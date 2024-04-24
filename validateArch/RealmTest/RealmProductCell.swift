import UIKit

class RealmProductCell: UITableViewCell {
    let marcaLabel = UILabel()
    let codigoLabel = UILabel()
    let quantidadeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCell() {
        let stackView = UIStackView(arrangedSubviews: [marcaLabel, codigoLabel, quantidadeLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5

        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with produto: RealmProduct) {
        marcaLabel.text = "Marca: \(produto.marca)"
        codigoLabel.text = "Código: \(produto.codigo)"
        quantidadeLabel.text = "Quantidade: \(produto.quantidade)"
    }
}

