import Foundation

public protocol Requests {
    var url: URL { get }
}

private let baseUrl = "https://api.github.com/"

enum Endpoint {
    case repos
    case issues(repo: String)
    
    var url: String {
        switch self {
        case .repos:
            return baseUrl + "users/intuit/repos"
        case .issues(let repo):
            return baseUrl + "repos/intuit/" + repo + "/issues"
        }
    }
}

struct GitHubRequest: Requests {
    public let url: URL
    
    public init?(endpoint: Endpoint) {
        let urlString = endpoint.url
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}

struct AvatarImageRequest: Requests {
    public let url: URL

    public init?(imagePath: String) {
        let urlString = imagePath
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}
