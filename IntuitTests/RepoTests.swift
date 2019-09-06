import XCTest
@testable import Intuit

class RepoTests: XCTestCase {

    lazy var owner: NSDictionary = [ "avatar_url": "https://avatars2.githubusercontent.com/u/2495066?v=4" ]
    lazy var json: NSDictionary = ["id": 41687006,
                              "name": "ami-query",
                              "owner": owner,
                              "description": "UITextField for iOS that enables the user to see both the Input Text and the Placeholder",
                              "created_at": "2016-07-28T17:45:35Z",
                              "stargazers_count": 1,
                              "watchers_count": 2,
                              "open_issues_count": 3,
                              "forks": 4]
    
    var repo: Repo?
    
    override func setUp() {
        repo = Repo(json: json)
    }

    override func tearDown() {
        repo = nil
    }
    
    func testStarFormat() {
        let formattedString = repo?.formattedStars
        XCTAssertEqual(formattedString, "Stars: 1")
    }
    
    func testWatchersFormat() {
        let formattedString = repo?.formattedWatchers
        XCTAssertEqual(formattedString, "Watchers: 2")
    }
    
    func testIssuesFormat() {
        let formattedString = repo?.formattedIssues
        XCTAssertEqual(formattedString, "Issues: 3")
    }
    
    func testForksFormat() {
        let formattedString = repo?.formattedForks
        XCTAssertEqual(formattedString, "Forks: 4")
    }
    
    func testCreatedFormat() {
        let formattedString = repo?.formattedCreatedDate
        XCTAssertEqual(formattedString, "Created: July 2016")
    }
}

