import Foundation
import RealmSwift

class RealmProduct: Object {
    @Persisted(primaryKey: true) var codigo: String
    @Persisted var marca: String = ""
    @Persisted var quantidade: Int = 0

    convenience init(marca: String, codigo: String, quantidade: Int) {
        self.init()
        self.marca = marca
        self.codigo = codigo
        self.quantidade = quantidade
    }

    required override init() {
        super.init()
    }
}

