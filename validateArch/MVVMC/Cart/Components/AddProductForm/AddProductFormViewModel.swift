//
//  AddProductFormViewModel.swift
//  validateArch
//
//  Created by Lucas Hubert on 19/04/24.
//

import Foundation
import Combine

enum errorAddProductForm: Error {
    case emptyForm
    case invalidCode
    case invalidQuantity
    case none
}

class AddProductFormViewModel: ObservableObject {
    
    // MARK: - Link to parent
    @Published var itemAdded: AddCartItemForm?
    @Published var isValid: Bool = false
    
    // MARK: - Link to view
    @Published var error: errorAddProductForm = .none
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        validate()
    }
    
    func validate() {
        if itemAdded?.code == "" && itemAdded?.quantity == 0 {
            isValid = false
            error = .emptyForm
        } else if itemAdded?.code == "" {
            isValid = false
            error = .invalidCode
        } else if itemAdded?.quantity == 0 {
            isValid = false
            error = .invalidQuantity
        } else {
            isValid = true
            error = .none
        }
    }
    
    func addItem(item: AddCartItemForm) async {
        validate()
        
        if isValid {
            await fakeRequest()
        }
    }
    
    func fakeRequest() async {
        isLoading = true
        print("item added: \(itemAdded!)")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
    
}
