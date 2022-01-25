@testable import TwitchIRC
import XCTest

final class ClearMessageTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@login=ronni;target-msg-id=abc-123-def;room-id=;tmi-sent-ts=1642860513538 :tmi.twitch.tv CLEARMSG #dallas :HeyGuys"
        
        let cm: ClearMessage = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(cm.channel, "dallas")
        XCTAssertEqual(cm.message, "HeyGuys")
        XCTAssertEqual(cm.userLogin, "ronni")
        XCTAssertEqual(cm.targetMessageId, "abc-123-def")
        XCTAssertEqual(cm.roomId, "")
        XCTAssertEqual(cm.tmiSentTs, 1642860513538)
        XCTAssertTrue(cm.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(cm.parsingLeftOvers)")
    }
}
