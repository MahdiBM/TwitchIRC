@testable import TwitchIRC
import XCTest

final class JoinTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":ronni!ronni@ronni.tmi.twitch.tv JOIN #dallas"
        let join: Join = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(join.channel, "dallas")
        XCTAssertEqual(join.userLogin, "ronni")
    }
}
