import Foundation

fileprivate extension Issue {
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case state = "state"
        case body = "body"
    }
}

struct Issue: Decodable {
    let title: String
    let state: String
    let body: String
}

//I put the initializer in an extension to keep the default initializer
extension Issue {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: CodingKeys.title)
        self.state = try container.decode(String.self, forKey: CodingKeys.state)
        self.body = try container.decode(String.self, forKey: CodingKeys.body)
    }
}

