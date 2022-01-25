@testable import TwitchIRC
import XCTest

final class UnknownMessageTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "noiadsonsdmsdada msp mdapfmadfo nadofnskm"
        let unknown: String = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(unknown, string)
    }
}
