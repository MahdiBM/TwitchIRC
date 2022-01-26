@testable import TwitchIRC
import XCTest

final class HostTargetTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch 1"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.numberOfViewers, 1)
        XCTAssertTrue(hostTarget.action == .start(hostedChannel: "twitch"))
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :- 130"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.numberOfViewers, 130)
        XCTAssertTrue(hostTarget.action == .stop)
    }
    
    func testParsedValues3() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :mahdimmbm"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.numberOfViewers, nil)
        XCTAssertTrue(hostTarget.action == .start(hostedChannel: "mahdimmbm"))
    }
    
    func testParsedValues4() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :-"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.numberOfViewers, nil)
        XCTAssertTrue(hostTarget.action == .stop)
    }
}

// MARK: Equatable for `HostTarget.Action` (basically)
private func == (lhs: HostTarget.Action, rhs: HostTarget.Action) -> Bool {
    "\(lhs)" == "\(rhs)"
}
