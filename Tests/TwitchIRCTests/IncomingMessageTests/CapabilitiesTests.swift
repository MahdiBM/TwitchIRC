@testable import TwitchIRC
import XCTest

final class CapabilitiesTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv CAP * ACK :twitch.tv/tags twitch.tv/commands"
        let caps: Capabilities = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(
            caps.capabilities.debugDescription,
            [Capability]([.tags, .commands]).debugDescription
        )
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv CAP * ACK :twitch.tv/membership"
        let caps: Capabilities = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(
            caps.capabilities.debugDescription,
            [Capability]([.membership]).debugDescription
        )
    }
}
