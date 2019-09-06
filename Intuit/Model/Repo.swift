import Foundation

fileprivate extension Repo {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case owner = "owner"
        case description = "description"
        case createdDate = "created_at"
        case stars = "stargazers_count"
        case watchers = "watchers_count"
        case issues = "open_issues_count"
        case forks = "forks"
    }
}

struct Repo: Decodable {
    let id: Int
    let name: String
    let owner: Owner
    let description: String
    let createdDate: String
    let stars: Int
    let watchers: Int
    let issues: Int
    let forks: Int
}

//I put the initializer in an extension to keep the default initializer
extension Repo {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: CodingKeys.id)
        self.name = try container.decode(String.self, forKey: CodingKeys.name)
        self.owner = try container.decode(Owner.self, forKey: CodingKeys.owner)
        self.description = try container.decode(String.self, forKey: CodingKeys.description)
        self.createdDate = try container.decode(String.self, forKey: CodingKeys.createdDate)
        self.stars = try container.decode(Int.self, forKey: CodingKeys.stars)
        self.watchers = try container.decode(Int.self, forKey: CodingKeys.watchers)
        self.issues = try container.decode(Int.self, forKey: CodingKeys.issues)
        self.forks = try container.decode(Int.self, forKey: CodingKeys.forks)
    }
    
    var formattedCreatedDate: String {
        // TODO: - Check if there is a cleaner way
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = formatter.date(from: createdDate) else { return "Created: Unknown" }
        formatter.dateFormat = "MMMM yyyy"
        let formattedDate = formatter.string(from: date)
        return "Created: \(formattedDate)"
    }
    
    //All of these string should be localized
    var formattedStars: String {
        return "Stars: \(stars)"
    }
    
    var formattedWatchers: String {
        return "Watchers: \(watchers)"
    }
    
    var formattedIssues: String {
        return "Issues: \(issues)"
    }
    
    var formattedForks: String {
        return "Forks: \(forks)"
    }
}
