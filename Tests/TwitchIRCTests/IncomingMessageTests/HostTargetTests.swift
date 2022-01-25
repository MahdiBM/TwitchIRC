@testable import TwitchIRC
import XCTest

final class HostTargetTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch 1"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.channelToBeHosted, "twitch")
        XCTAssertEqual(hostTarget.numberOfViewers, 1)
        XCTAssertEqual(hostTarget.action, .start)
    }
    
    func testParsedValues2() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :- 130"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.channelToBeHosted, nil)
        XCTAssertEqual(hostTarget.numberOfViewers, 130)
        XCTAssertEqual(hostTarget.action, .stop)
    }
    
    func testParsedValues3() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.channelToBeHosted, "twitch")
        XCTAssertEqual(hostTarget.numberOfViewers, nil)
        XCTAssertEqual(hostTarget.action, .start)
    }
    
    func testParsedValues4() throws {
        let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :-"
        let hostTarget: HostTarget = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(hostTarget.channel, "twitchdev")
        XCTAssertEqual(hostTarget.channelToBeHosted, nil)
        XCTAssertEqual(hostTarget.numberOfViewers, nil)
        XCTAssertEqual(hostTarget.action, .stop)
    }
}
