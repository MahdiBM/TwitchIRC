@testable import TwitchIRC
import XCTest

final class ChannelEntranceTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":royalealchemist.tmi.twitch.tv 353 royalealchemist = #fxyen :royalealchemist"
        let ent: ChannelEntrance = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(ent.message, "royalealchemist")
        XCTAssertEqual(ent.userLogin, "royalealchemist")
        XCTAssertEqual(ent.joinedChannel, "fxyen")
        XCTAssertEqual(ent.number, 353)
    }
    
    func testParsedValues2() throws {
        let string = ":royalealchemist.tmi.twitch.tv 366 royalealchemist #fxyen :End of /NAMES list"
        let ent: ChannelEntrance = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(ent.message, "End of /NAMES list")
        XCTAssertEqual(ent.userLogin, "royalealchemist")
        XCTAssertEqual(ent.joinedChannel, "fxyen")
        XCTAssertEqual(ent.number, 366)
    }
}
