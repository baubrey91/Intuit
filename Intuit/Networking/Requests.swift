import Foundation

public protocol Requests {
    var url: URL { get }
}

private var baseUrl: String = "https://api.github.com/users/intuit/repos"

public struct movieRequest: Requests {
    public let url: URL
    
    public init?() {
        let urlString = baseUrl
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}

public struct movieImageRequest: Requests {
    public let url: URL
    
    public init?(imagePath: String) {
        let urlString = imagePath
        guard let url = URL(string: urlString) else { return nil }
        self.url = url
    }
}
