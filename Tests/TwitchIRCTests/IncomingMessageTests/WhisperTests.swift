@testable import TwitchIRC
import XCTest

final class WhisperTests: XCTestCase {
    
    func testParsedValues1() throws {
        let string = "@badges=;color=;display-name=drizzlepickles;emotes=;message-id=1;thread-id=684111155_699948886;turbo=0;user-id=699948886;user-type= :drizzlepickles!drizzlepickles@drizzlepickles.tmi.twitch.tv WHISPER royalealchemist :hello sir"
        
        let whisper: Whisper = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(whisper.receiver, "royalealchemist")
        XCTAssertEqual(whisper.message, "hello sir")
        XCTAssertEqual(whisper.badges, [])
        XCTAssertEqual(whisper.color, "")
        XCTAssertEqual(whisper.displayName, "drizzlepickles")
        XCTAssertEqual(whisper.emotes, "")
        XCTAssertEqual(whisper.messageId, "1")
        XCTAssertEqual(whisper.threadId, "684111155_699948886")
        XCTAssertEqual(whisper.userId, "699948886")
        XCTAssertTrue(whisper.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(whisper.parsingLeftOvers)")
    }
    
    func testParsedValues2() throws {
        let string = "@badges=;color=#1E90FF;display-name=MahdiMMBM;emotes=30259:0-6,8-14;message-id=3;thread-id=519827148_684111155;turbo=0;user-id=519827148;user-type= :mahdimmbm!mahdimmbm@mahdimmbm.tmi.twitch.tv WHISPER royalealchemist :HeyGuys HeyGuys"
        
        let whisper: Whisper = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(whisper.receiver, "royalealchemist")
        XCTAssertEqual(whisper.message, "HeyGuys HeyGuys")
        XCTAssertEqual(whisper.badges, [])
        XCTAssertEqual(whisper.color, "#1E90FF")
        XCTAssertEqual(whisper.displayName, "MahdiMMBM")
        XCTAssertEqual(whisper.emotes, "30259:0-6,8-14")
        XCTAssertEqual(whisper.messageId, "3")
        XCTAssertEqual(whisper.threadId, "519827148_684111155")
        XCTAssertEqual(whisper.userId, "519827148")
        XCTAssertTrue(whisper.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(whisper.parsingLeftOvers)")
    }
}
