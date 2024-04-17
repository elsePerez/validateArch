//
//  ViperViewController.swift
//  validateArch
//
//  Created by Lucas Hubert on 17/04/24.
//

import Foundation
import UIKit


class ViperPresenter: UIViewController {
    
    private lazy var mainView = ViperView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    func registerCell() {
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "listItem")
    }
}

extension ViperPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
