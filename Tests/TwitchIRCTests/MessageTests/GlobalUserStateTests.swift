@testable import TwitchIRC
import XCTest

final class GlobalUserStateTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@badge-info=subscriber/8;badges=subscriber/6;color=#0D4200;display-name=dallas;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;turbo=0;user-id=1337;user-type=admin :tmi.twitch.tv GLOBALUSERSTATE"
        let gus: GlobalUserState = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(gus.badgeInfo, ["subscriber/8"])
        XCTAssertEqual(gus.badges, ["subscriber/6"])
        XCTAssertEqual(gus.color, "#0D4200")
        XCTAssertEqual(gus.displayName, "dallas")
        XCTAssertEqual(gus.emoteSets, ["0", "33", "50", "237", "793", "2126", "3517", "4578", "5569", "9400", "10337", "12239"])
        XCTAssertEqual(gus.userId, "1337")
        XCTAssertTrue(gus.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(gus.parsingLeftOvers)")
    }
}
