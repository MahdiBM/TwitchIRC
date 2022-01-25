@testable import TwitchIRC
import XCTest

final class RoomStateTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@emote-only=1;followers-only=-1;r9k=1;slow=10;subs-only=1;room-id=324 :tmi.twitch.tv ROOMSTATE #dallas"
        
        let roomState: RoomState = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(roomState.channel, "dallas")
        XCTAssertEqual(roomState.emoteOnly, true)
        XCTAssertEqual(roomState.followersOnly, -1)
        XCTAssertEqual(roomState.r9k, true)
        XCTAssertEqual(roomState.roomId, "324")
        XCTAssertEqual(roomState.slow, 10)
        XCTAssertEqual(roomState.subsOnly, true)
        XCTAssertEqual(roomState.rituals, false)
        XCTAssertTrue(roomState.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(roomState.parsingLeftOvers)")
    }
    
    /// Test independency from the sequence `@emote-only`.
    /// Parsing shouldn't count on `@` always being behind `emote-only`.
    func testParsedValues2() throws {
        let string = "@followers-only=10;emote-only=1;r9k=1;slow=10;subs-only=1;room-id=324 :tmi.twitch.tv ROOMSTATE #dallas"
        
        let roomState: RoomState = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(roomState.channel, "dallas")
        XCTAssertEqual(roomState.emoteOnly, true)
        XCTAssertEqual(roomState.followersOnly, 10)
        XCTAssertEqual(roomState.r9k, true)
        XCTAssertEqual(roomState.roomId, "324")
        XCTAssertEqual(roomState.slow, 10)
        XCTAssertEqual(roomState.subsOnly, true)
        XCTAssertEqual(roomState.rituals, false)
        XCTAssertTrue(roomState.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(roomState.parsingLeftOvers)")
    }
}
