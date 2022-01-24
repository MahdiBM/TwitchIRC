@testable import TwitchIRC
import XCTest

final class PingPongTests: XCTestCase {
    
    func testPingParsedValues1() throws {
        let string = "PING :tmi.twitch.tv"
        let ping: String = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(ping, "ping")
    }
    
    func testPongParsedValues1() throws {
        let string = "PONG :tmi.twitch.tv"
        let pong: String = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(pong, "pong")
    }
}
