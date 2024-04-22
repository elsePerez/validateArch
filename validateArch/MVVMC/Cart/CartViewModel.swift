//
//  CartViewModel.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import Combine

struct CartItem: Codable, Equatable {
    let name: String
    let price: Int
}

class CartViewModel: ObservableObject {
    
    let coordinator: MainCoordinator
    
    var addProductFormViewModel = AddProductFormViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        
        addProductFormViewModel.$itemAdded
            .sink { item in
                guard let item = item else { return }
                self.addItemFromForm(item: item)
            }
            .store(in: &cancellables)
    }
    
    @Published var items: [CartItem] = []
    @Published var itemsCount: Int = 0
    
    func addItemFromForm(item: AddCartItemForm) {
        itemsCount += 1
        self.items.append(CartItem(name: item.code, price: 10))
    }
    
    func removeItem(item: CartItem) {
        self.items.removeAll { $0 == item }
    }
    
    func removeAll() {
        self.items.removeAll()
    }
    
    func getItem(index: Int) -> CartItem {
        return self.items[index]
    }
    
    func getItemTitle(index: Int) -> String {
        return self.items[index].name
    }
    
    func getItemPrice(index: Int) -> String {
        return String(self.items[index].price)
    }
    
    func getTotal() -> Int {
        var total = 0
        for item in self.items {
            total += item.price
        }
        return total
    }
}

