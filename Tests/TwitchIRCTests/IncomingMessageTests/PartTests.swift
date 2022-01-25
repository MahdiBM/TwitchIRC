@testable import TwitchIRC
import XCTest

final class PartTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":ronni!ronni@ronni.tmi.twitch.tv PART #dallas"
        let part: Part = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(part.channel, "dallas")
        XCTAssertEqual(part.userLogin, "ronni")
    }
}
