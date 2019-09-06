import XCTest
@testable import Intuit

class ExtensionsTests: XCTestCase {

    var stringTest: String?
    
    override func setUp() {
        stringTest = ""
    }
    
    override func tearDown() {
        stringTest = nil
    }
    
    func testFullString() {
        stringTest = "Hello"
        XCTAssertFalse(stringTest!.isEmptyOrWhiteSpace)
    }
    
    func testSpaceString() {
        stringTest = "   "
        XCTAssert(stringTest!.isEmptyOrWhiteSpace)
    }
    
    func testEmptyString() {
        stringTest = ""
        XCTAssert(stringTest!.isEmptyOrWhiteSpace)
    }
}
