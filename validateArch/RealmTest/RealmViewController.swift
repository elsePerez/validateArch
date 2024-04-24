import UIKit
import Combine

class RealmViewController: UIViewController {
    private let viewModel = RealmViewModel()
    private var cancellables: Set<AnyCancellable> = []
    private let marcasDisponiveis = [
        "Natura",
        "Avon",
        "Casa&Estilo"
    ]
    private var selectedMarca: String = "Natura"

    private lazy var marcaPicker: UIPickerView = {
        let marca = UIPickerView()
        marca.dataSource = self
        marca.delegate = self
        marca.selectRow(0, inComponent: 0, animated: false)
        marca.translatesAutoresizingMaskIntoConstraints = false
        return marca
    }()

    private lazy var codigoField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Código"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let quantidadeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Quantidade"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RealmProductCell.self, forCellReuseIdentifier: "RealmProductCell")
        return tableView
    }()

    private lazy var inputStack: UIStackView = {
        let inputStack = UIStackView(arrangedSubviews: [marcaPicker, codigoField, quantidadeField])
        inputStack.axis = .vertical
        inputStack.distribution = .fill
        inputStack.spacing = 10
        return inputStack
    }()

    private lazy var addProductButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.setTitle("Adicionar", for: .normal)
        button.addTarget(self, action: #selector(adicionarProduto), for: .touchUpInside)
        return button
    }()

    private lazy var rootStackView: UIStackView = {
        let mainStack = UIStackView(arrangedSubviews: [inputStack, addProductButton, productsCount, tableView])
        mainStack.axis = .vertical
        mainStack.spacing = 20
        return mainStack
    }()

    private lazy var productsCount = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        viewModel.$produtos
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.productsCount.text = "Produtos totais: \(String(self?.viewModel.produtos.count ?? 0))"
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(rootStackView)
        rootStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            rootStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            marcaPicker.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc private func adicionarProduto() {
            if let codigo = codigoField.text,
               let quantidadeText = quantidadeField.text,
               let quantidade = Int(quantidadeText) {
                let marca = selectedMarca

                viewModel.adicionarProduto(marca: marca, codigo: codigo, quantidade: quantidade)

                codigoField.text = ""
                quantidadeField.text = ""
            }
        }
}

extension RealmViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return marcasDisponiveis.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return marcasDisponiveis[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMarca = marcasDisponiveis[row]
    }
}

extension RealmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.produtos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmProductCell", for: indexPath) as! RealmProductCell
        let produto = viewModel.produtos[indexPath.row]
        cell.configure(with: produto)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let produto = viewModel.produtos[indexPath.row]
            viewModel.removerProdutos(produto: produto)

            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
