//
//  MainCoordinator.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import UIKit

class MainCoordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    
    func start() {
        let vm = CartViewModel(coordinator: self)
        let vc = CartViewController(vm: vm)

        navigationController.pushViewController(vc, animated: false)
    }
    
}
