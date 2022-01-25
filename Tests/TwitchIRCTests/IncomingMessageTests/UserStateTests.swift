@testable import TwitchIRC
import XCTest

final class UserStateTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@badge-info=;badges=staff/1;color=#0D4200;display-name=ronni;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;mod=1;subscriber=1;turbo=1;user-type=staff :tmi.twitch.tv USERSTATE #dallas"
        
        let userState: UserState = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(userState.channel, "dallas")
        XCTAssertEqual(userState.badgeInfo, [])
        XCTAssertEqual(userState.badges, ["staff/1"])
        XCTAssertEqual(userState.color, "#0D4200")
        XCTAssertEqual(userState.displayName, "ronni")
        XCTAssertEqual(userState.emoteSets, ["0", "33", "50", "237", "793", "2126", "3517", "4578", "5569", "9400", "10337", "12239"])
        XCTAssertTrue(userState.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(userState.parsingLeftOvers)")
    }
}
