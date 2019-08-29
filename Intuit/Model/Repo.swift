import Foundation

fileprivate extension Repo {
    struct JSONKey {
        static let id = "id"
        static let name = "name"
        static let forks = "forks"
        static let index = "index"
    }
}

public struct Repo {
    var id: Int
    var name: String
    var forks: Int
    
    init(json: NSDictionary) {
        self.id = json[JSONKey.id] as! Int
        self.name = json[JSONKey.name] as! String
        self.forks = json[JSONKey.forks] as! Int
    }
}
