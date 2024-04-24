import Combine
import Foundation
import RealmSwift

class RealmViewModel: ObservableObject {
    private var realm: Realm
    @Published var produtos: [RealmProduct] = []

    init() {
        Realm.configureWithMigration()
        realm = try! Realm()
        produtos = Array(realm.objects(RealmProduct.self))
    }

    func adicionarProduto(marca: String, codigo: String, quantidade: Int) {
        let novoProduto = RealmProduct(marca: marca, codigo: codigo, quantidade: quantidade)
        realm.addOrUpdateProduct(product: novoProduto)
        produtos = Array(realm.objects(RealmProduct.self))
    }

    func removerProdutos(produto: RealmProduct) {
        realm.deleteObject(ofType: RealmProduct.self, codigo: produto.codigo)
        produtos = Array(realm.objects(RealmProduct.self))
    }

}

extension Realm {
    func addOrUpdateProduct(product: RealmProduct) {
        do {
            try self.write {
                if let existingProduct = self.objects(RealmProduct.self).filter("codigo == %@", product.codigo).first {
                    existingProduct.marca = product.marca
                    existingProduct.quantidade = product.quantidade
                } else {
                    self.add(product)
                }
            }
        } catch {
            print("Erro ao adicionar ou atualizar o produto no Realm: \(error)")
        }
    }

    func deleteObject<T: Object>(ofType objectType: T.Type, codigo: String) {
        do {
            try self.write {
                let objeto = self.objects(objectType).filter("codigo == %@", codigo).first
                if let objeto = objeto {
                    self.delete(objeto)
                }
            }
        } catch {
            print("Erro ao deletar o objeto do Realm: \(error)")
        }
    }

    static func configureWithMigration() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: RealmProduct.className()) { oldObject, newObject in
                        newObject?["codigo"] = oldObject?["codigo"]
                    }
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config

        // EXPLICACAO DO POR QUE DESSA FUNCAO
        // FEITA PARA TRATAR ERRO DE INSTANCIA E CONFLITO DE BANCO DE DADOS QUE O FILIPO QUESTIONOU
        /*
         BOTEI EXPLICACAO DO CHAT GPT QUE EXPLICA MELHOR QUE EU :D
         Quando você trabalha com o banco de dados Realm em um aplicativo, as estruturas de dados podem mudar ao longo do tempo, seja por meio de alterações nos atributos de uma classe do Realm, por adição de novos campos, ou por alterações em relacionamentos entre classes. Quando isso acontece, é importante aplicar migrações para garantir que o banco de dados continue a funcionar corretamente sem causar falhas ou perda de dados.

         O método Realm.configureWithMigration() que propus é uma maneira de garantir que o Realm está configurado para lidar com essas mudanças no esquema de dados. Quando você chama essa função antes de criar uma instância do Realm, está assegurando que:

         Versão do Esquema é Atualizada: Ao definir uma versão do esquema, você informa ao Realm qual é a versão atual do banco de dados. Se a versão muda, isso indica que houve alterações no esquema e uma migração é necessária.
         Bloco de Migração é Aplicado: Quando a versão do esquema muda, o bloco de migração é executado para fazer as mudanças necessárias no banco de dados. Por exemplo, se você adicionar uma chave primária ou um novo campo a uma classe do Realm, o bloco de migração pode garantir que os dados existentes sejam atualizados para atender ao novo esquema.
         Configuração Padrão é Atualizada: Ao aplicar a configuração padrão, você garante que todas as instâncias do Realm criadas após a configuração sejam consistentes com as regras de migração definidas. Isso reduz a chance de erros relacionados ao banco de dados em seu aplicativo.
         Por que é importante chamar Realm.configureWithMigration() antes de criar uma instância do Realm?

         Prevenir Erros de Migração: Se você criar uma instância do Realm sem uma estratégia de migração quando o esquema mudou, isso resultará em erros que podem causar falhas no aplicativo ou perda de dados. Ao chamar o método de configuração, você reduz esse risco.
         Manter a Consistência dos Dados: Migrações bem definidas ajudam a manter a consistência e integridade dos dados mesmo quando o esquema muda. Sem migrações, o banco de dados pode ficar corrompido ou inconsistente.
         Facilitar Manutenção e Atualizações Futuras: Ter um método centralizado para configurar migrações facilita futuras alterações no esquema do banco de dados. Sempre que uma mudança for necessária, você pode atualizar o bloco de migração sem precisar refatorar grandes partes do código.
         Em resumo, chamar Realm.configureWithMigration() é uma prática para garantir que seu aplicativo está pronto para lidar com mudanças no banco de dados Realm de maneira segura e eficaz. É uma etapa crucial para evitar erros de migração e manter a consistência dos dados ao longo do ciclo de vida do aplicativo.
         */
    }
}
