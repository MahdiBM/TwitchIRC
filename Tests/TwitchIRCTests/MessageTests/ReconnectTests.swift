@testable import TwitchIRC
import XCTest

final class ReconnectTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv RECONNECT"
        let reconnect: String = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(reconnect, "reconnect")
    }
}
