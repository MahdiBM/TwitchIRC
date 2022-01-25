@testable import TwitchIRC
import XCTest

final class PrivateMessageTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@badge-info=;badges=global_mod/1,turbo/1;color=#0D4200;display-name=ronni;emotes=25:0-4,12-16/1902:6-10;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=global_mod :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :Kappa Keepo Kappa"
        
        let msg: PrivateMessage = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(msg.channel, "ronni")
        XCTAssertEqual(msg.message, "Kappa Keepo Kappa")
        XCTAssertEqual(msg.badgeInfo, [])
        XCTAssertEqual(msg.badges, ["global_mod/1", "turbo/1"])
        XCTAssertEqual(msg.bits, "")
        XCTAssertEqual(msg.color, "#0D4200")
        XCTAssertEqual(msg.displayName, "ronni")
        XCTAssertEqual(msg.userLogin, "ronni")
        XCTAssertEqual(msg.emotes, ["25:0-4", "12-16/1902:6-10"])
        XCTAssertEqual(msg.emoteOnly, false)
        XCTAssertEqual(msg.flags, [])
        XCTAssertEqual(msg.firstMessage, false)
        XCTAssertEqual(msg.msgId, "")
        XCTAssertEqual(msg.id, "b34ccfc7-4977-403a-8a94-33c6bac34fb8")
        XCTAssertEqual(msg.customRewardId, "")
        XCTAssertEqual(msg.roomId, "1337")
        XCTAssertEqual(msg.tmiSentTs, 1507246572675)
        XCTAssertEqual(msg.clientNonce, "")
        XCTAssertEqual(msg.userId, "1337")
        XCTAssertTrue(msg.replyParent == .init())
        XCTAssertTrue(msg.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(msg.parsingLeftOvers)")
    }
    
    /// Tests a message with bits.
    func testParsedValues2() throws {
        let string = "@badge-info=;badges=staff/1,bits/1000;bits=100;color=;display-name=ronni;emotes=;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :cheer100"
        
        let msg: PrivateMessage = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(msg.channel, "ronni")
        XCTAssertEqual(msg.message, "cheer100")
        XCTAssertEqual(msg.badgeInfo, [])
        XCTAssertEqual(msg.badges, ["staff/1", "bits/1000"])
        XCTAssertEqual(msg.bits, "100")
        XCTAssertEqual(msg.color, "")
        XCTAssertEqual(msg.displayName, "ronni")
        XCTAssertEqual(msg.userLogin, "ronni")
        XCTAssertEqual(msg.emotes, [])
        XCTAssertEqual(msg.emoteOnly, false)
        XCTAssertEqual(msg.flags, [])
        XCTAssertEqual(msg.firstMessage, false)
        XCTAssertEqual(msg.msgId, "")
        XCTAssertEqual(msg.id, "b34ccfc7-4977-403a-8a94-33c6bac34fb8")
        XCTAssertEqual(msg.customRewardId, "")
        XCTAssertEqual(msg.roomId, "1337")
        XCTAssertEqual(msg.tmiSentTs, 1507246572675)
        XCTAssertEqual(msg.clientNonce, "")
        XCTAssertEqual(msg.userId, "1337")
        XCTAssertTrue(msg.replyParent == .init())
        XCTAssertTrue(msg.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(msg.parsingLeftOvers)")
    }
    
    /// Tests a single weird character in the message (here UTF8 [217, 145])
    /// The character is barely visible in Xcode.
    func testParsedValues3() throws {
        let string = "@badge-info=;badges=;client-nonce=3dc1eef952878c31098361ebfc5017d7;color=;display-name=littlesnakysnake;emotes=;first-msg=0;flags=;id=9a323937-80fe-442a-b3a9-8c32e37cfb4f;mod=0;room-id=180980116;subscriber=0;tmi-sent-ts=1642848914241;turbo=0;user-id=478769067;user-type= :littlesnakysnake!littlesnakysnake@littlesnakysnake.tmi.twitch.tv PRIVMSG #carl_the_legend :ّ"
        
        let msg: PrivateMessage = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(msg.channel, "carl_the_legend")
        XCTAssertEqual(msg.message, "ّ")
        XCTAssertEqual(msg.badgeInfo, [])
        XCTAssertEqual(msg.badges, [])
        XCTAssertEqual(msg.bits, "")
        XCTAssertEqual(msg.color, "")
        XCTAssertEqual(msg.displayName, "littlesnakysnake")
        XCTAssertEqual(msg.userLogin, "littlesnakysnake")
        XCTAssertEqual(msg.emotes, [])
        XCTAssertEqual(msg.emoteOnly, false)
        XCTAssertEqual(msg.flags, [])
        XCTAssertEqual(msg.firstMessage, false)
        XCTAssertEqual(msg.msgId, "")
        XCTAssertEqual(msg.id, "9a323937-80fe-442a-b3a9-8c32e37cfb4f")
        XCTAssertEqual(msg.customRewardId, "")
        XCTAssertEqual(msg.roomId, "180980116")
        XCTAssertEqual(msg.tmiSentTs, 1642848914241)
        XCTAssertEqual(msg.clientNonce, "3dc1eef952878c31098361ebfc5017d7")
        XCTAssertEqual(msg.userId, "478769067")
        XCTAssertTrue(msg.replyParent == .init())
        XCTAssertTrue(msg.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(msg.parsingLeftOvers)")
    }
    
    /// Tests a replied message that has reply parent info.
    func testParsedValues4() throws {
        let string = "@badge-info=;badges=moderator/1;client-nonce=00e8c3279eebbb43ad80273324e10d28;color=#1E90FF;display-name=MahdiMMBM;emotes=;first-msg=0;flags=;id=7fd9a2fa-d537-4a31-b847-7e081c4c088d;mod=1;reply-parent-display-name=jay_999666;reply-parent-msg-body=!gc;reply-parent-msg-id=92d75439-9bfa-42d2-b20c-7dc4a2c07f6b;reply-parent-user-id=621834053;reply-parent-user-login=jay_999666;room-id=751562865;subscriber=0;tmi-sent-ts=1642084941607;turbo=0;user-id=519827148;user-type=mod :mahdimmbm!mahdimmbm@mahdimmbm.tmi.twitch.tv PRIVMSG #mohamedlightcr :@jay_999666 !gcs"
        
        let msg: PrivateMessage = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(msg.channel, "mohamedlightcr")
        XCTAssertEqual(msg.message, "@jay_999666 !gcs")
        XCTAssertEqual(msg.badgeInfo, [])
        XCTAssertEqual(msg.badges, ["moderator/1"])
        XCTAssertEqual(msg.bits, "")
        XCTAssertEqual(msg.color, "#1E90FF")
        XCTAssertEqual(msg.displayName, "MahdiMMBM")
        XCTAssertEqual(msg.userLogin, "mahdimmbm")
        XCTAssertEqual(msg.emotes, [])
        XCTAssertEqual(msg.emoteOnly, false)
        XCTAssertEqual(msg.flags, [])
        XCTAssertEqual(msg.firstMessage, false)
        XCTAssertEqual(msg.msgId, "")
        XCTAssertEqual(msg.id, "7fd9a2fa-d537-4a31-b847-7e081c4c088d")
        XCTAssertEqual(msg.customRewardId, "")
        XCTAssertEqual(msg.roomId, "751562865")
        XCTAssertEqual(msg.tmiSentTs, 1642084941607)
        XCTAssertEqual(msg.clientNonce, "00e8c3279eebbb43ad80273324e10d28")
        XCTAssertEqual(msg.userId, "519827148")
        XCTAssertTrue(msg.replyParent == .init(
            displayName: "jay_999666",
            userLogin: "jay_999666",
            message: "!gc",
            id: "92d75439-9bfa-42d2-b20c-7dc4a2c07f6b",
            userId: "621834053"
        ))
        XCTAssertTrue(msg.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(msg.parsingLeftOvers)")
    }
}

// MARK: PrivateMessage.ReplyParent Equatable (basically)
private func == (lhs: PrivateMessage.ReplyParent, rhs: PrivateMessage.ReplyParent) -> Bool {
    lhs.displayName == rhs.displayName
    && lhs.userLogin == rhs.userLogin
    && lhs.message == rhs.message
    && lhs.id == rhs.id
    && lhs.userId == rhs.userId
}
