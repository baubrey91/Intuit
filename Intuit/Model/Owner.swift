import Foundation

fileprivate extension Owner {
    enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
    }
}

struct Owner: Decodable {
    let avatarImage: String
}

//I put the initial in an extension to keep the default initializer
extension Owner {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.avatarImage = try container.decode(String.self, forKey: CodingKeys.avatar_url)
    }
}
