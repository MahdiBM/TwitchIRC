@testable import TwitchIRC
import XCTest

final class MessageWithBadgesTests: XCTestCase {
    
    func testAllTrue() throws {
        let message = MockMessageWithBadges(
            badges: [
                "global_mod/1",
                "moderator/1",
                "broadcaster/1",
                "subscriber/1",
                "vip/1",
                "turbo/1",
                "staff/1"
            ]
        )
        
        XCTAssertEqual(message.isMod, true)
        XCTAssertEqual(message.isSubscriber, true)
        XCTAssertEqual(message.isBroadcaster, true)
        XCTAssertEqual(message.isVIP, true)
        XCTAssertEqual(message.isTurbo, true)
        XCTAssertEqual(message.isStaff, true)
        XCTAssertEqual(message.isGlobalMod, true)
    }
    
    func testAllFalse() throws {
        let message = MockMessageWithBadges(badges: [])
        
        XCTAssertEqual(message.isMod, false)
        XCTAssertEqual(message.isSubscriber, false)
        XCTAssertEqual(message.isBroadcaster, false)
        XCTAssertEqual(message.isVIP, false)
        XCTAssertEqual(message.isTurbo, false)
        XCTAssertEqual(message.isStaff, false)
        XCTAssertEqual(message.isGlobalMod, false)
    }
}

private struct MockMessageWithBadges: MessageWithBadges {
    let badges: [String]
}
