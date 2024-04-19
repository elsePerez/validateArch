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

protocol CartViewModelProtocol {
    func addItem(item: CartItem)
    func removeItem(item: CartItem)
    func removeAll()
    func getItems() -> [CartItem]
    func getItemsCount() -> Int
    func getItem(index: Int) -> CartItem
    func getItemTitle(index: Int) -> String
    func getItemPrice(index: Int) -> String
    func getTotal() -> Int
}

class CartViewModel: ObservableObject {
    
    let coordinator: MainCoordinator
    
    var cancellables = Set<AnyCancellable>()
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    @Published var items: [CartItem] = []
    @Published var itemsCount: Int = 0
    
    func addItem(item: CartItem) {
        itemsCount += 1
        self.items.append(item)
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

