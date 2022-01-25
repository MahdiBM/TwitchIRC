@testable import TwitchIRC
import XCTest

final class UserNoticeTests: XCTestCase {
    
    typealias Action = UserNotice.MessageID
    
    func unwrapInnerValue<T>(
        action: UserNotice.MessageID,
        as type: T.Type = T.self,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T {
        try XCTUnwrap(
            action.anyValue as? T,
            "MessageID case not expected. Available value: \(action.anyValue), Expected type: \(T.self)",
            file: file,
            line: line
        )
    }
    
    func testParsedValues1() throws {
        let string = #"@badge-info=;badges=staff/1,broadcaster/1,turbo/1;color=#008000;display-name=ronni;emotes=;id=db25007f-7a18-43eb-9379-80131e44d633;login=ronni;mod=0;msg-id=resub;msg-param-cumulative-months=6;msg-param-streak-months=2;msg-param-should-share-streak=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Prime;room-id=1337;subscriber=1;system-msg=ronni\shas\ssubscribed\sfor\s6\smonths!;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :tmi.twitch.tv USERNOTICE #dallas :Great stream -- keep it up!"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dallas")
        XCTAssertEqual(un.message, "Great stream -- keep it up!")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["staff/1", "broadcaster/1", "turbo/1"])
        XCTAssertEqual(un.color, "#008000")
        XCTAssertEqual(un.displayName, "ronni")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "db25007f-7a18-43eb-9379-80131e44d633")
        XCTAssertEqual(un.userLogin, "ronni")
        XCTAssertEqual(un.roomId, "1337")
        XCTAssertEqual(un.systemMessage, #"ronni\shas\ssubscribed\sfor\s6\smonths!"#)
        XCTAssertEqual(un.tmiSentTs, 1507246572675)
        XCTAssertEqual(un.userId, "1337")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.ReSubInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.cumulativeMonths, 6)
        XCTAssertEqual(info.shouldShareStreak, true)
        XCTAssertEqual(info.streakMonths, 2)
        XCTAssertEqual(info.subPlan, .prime)
        XCTAssertEqual(info.subPlanName, "Prime")
        XCTAssertEqual(info.anonGift, false)
        XCTAssertEqual(info.months, 0)
        XCTAssertEqual(info.multimonthDuration, 0)
        XCTAssertEqual(info.multimonthTenure, false)
        XCTAssertEqual(info.wasGifted, false)
        XCTAssertEqual(info.giftMonthBeingRedeemed, 0)
        XCTAssertEqual(info.giftMonths, 0)
        XCTAssertEqual(info.gifterId, "")
        XCTAssertEqual(info.gifterLogin, "")
        XCTAssertEqual(info.gifterName, "")
    }
    
    func testParsedValues2() throws {
        let string = #"@badge-info=;badges=staff/1,premium/1;color=#0000FF;display-name=TWW2;emotes=;id=e9176cd8-5e22-4684-ad40-ce53c2561c5e;login=tww2;mod=0;msg-id=subgift;msg-param-months=1;msg-param-recipient-display-name=Mr_Woodchuck;msg-param-recipient-id=89614178;msg-param-recipient-user-name=mr_woodchuck;msg-param-sub-plan-name=House\sof\sNyoro~n;msg-param-sub-plan=1000;room-id=19571752;subscriber=0;system-msg=TWW2\sgifted\sa\sTier\s1\ssub\sto\sMr_Woodchuck!;tmi-sent-ts=1521159445153;turbo=0;user-id=13405587;user-type=staff :tmi.twitch.tv USERNOTICE #forstycup"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "forstycup")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["staff/1", "premium/1"])
        XCTAssertEqual(un.color, "#0000FF")
        XCTAssertEqual(un.displayName, "TWW2")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "e9176cd8-5e22-4684-ad40-ce53c2561c5e")
        XCTAssertEqual(un.userLogin, "tww2")
        XCTAssertEqual(un.roomId, "19571752")
        XCTAssertEqual(un.systemMessage, #"TWW2\sgifted\sa\sTier\s1\ssub\sto\sMr_Woodchuck!"#)
        XCTAssertEqual(un.tmiSentTs, 1521159445153)
        XCTAssertEqual(un.userId, "13405587")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.SubGiftInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.months, 1)
        XCTAssertEqual(info.recipientDisplayName, "Mr_Woodchuck")
        XCTAssertEqual(info.recipientId, "89614178")
        XCTAssertEqual(info.recipientUserName, "mr_woodchuck")
        XCTAssertEqual(info.subPlan, .tier1)
        XCTAssertEqual(info.subPlanName, #"House\sof\sNyoro~n"#)
        XCTAssertEqual(info.giftMonths, 0)
        XCTAssertEqual(info.originId, "")
        XCTAssertEqual(info.senderCount, 0)
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
    }
    
    func testParsedValues3() throws {
        let string = #"@badge-info=;badges=broadcaster/1,subscriber/6;color=;display-name=qa_subs_partner;emotes=;flags=;id=b1818e3c-0005-490f-ad0a-804957ddd760;login=qa_subs_partner;mod=0;msg-id=anonsubgift;msg-param-months=3;msg-param-recipient-display-name=TenureCalculator;msg-param-recipient-id=135054130;msg-param-recipient-user-name=tenurecalculator;msg-param-sub-plan-name=t111;msg-param-sub-plan=1000;room-id=196450059;subscriber=1;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sTenureCalculator!\s;tmi-sent-ts=1542063432068;turbo=0;user-id=196450059;user-type= :tmi.twitch.tv USERNOTICE #qa_subs_partner"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "qa_subs_partner")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["broadcaster/1", "subscriber/6"])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "qa_subs_partner")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "b1818e3c-0005-490f-ad0a-804957ddd760")
        XCTAssertEqual(un.userLogin, "qa_subs_partner")
        XCTAssertEqual(un.roomId, "196450059")
        XCTAssertEqual(un.systemMessage, #"An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sTenureCalculator!\s"#)
        XCTAssertEqual(un.tmiSentTs, 1542063432068)
        XCTAssertEqual(un.userId, "196450059")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.SubGiftInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.months, 3)
        XCTAssertEqual(info.recipientDisplayName, "TenureCalculator")
        XCTAssertEqual(info.recipientId, "135054130")
        XCTAssertEqual(info.recipientUserName, "tenurecalculator")
        XCTAssertEqual(info.subPlan, .tier1)
        XCTAssertEqual(info.subPlanName, "t111")
        XCTAssertEqual(info.giftMonths, 0)
        XCTAssertEqual(info.originId, "")
        XCTAssertEqual(info.senderCount, 0)
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
    }
    
    func testParsedValues4() throws {
        let string = #"@badge-info=;badges=turbo/1;color=#9ACD32;display-name=TestChannel;emotes=;id=3d830f12-795c-447d-af3c-ea05e40fbddb;login=testchannel;mod=0;msg-id=raid;msg-param-displayName=TestChannel;msg-param-login=testchannel;msg-param-viewerCount=15;room-id=56379257;subscriber=0;system-msg=15\sraiders\sfrom\sTestChannel\shave\sjoined\n!;tmi-sent-ts=1507246572675;turbo=1;user-id=123456;user-type= :tmi.twitch.tv USERNOTICE #othertestchannel"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "othertestchannel")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["turbo/1"])
        XCTAssertEqual(un.color, "#9ACD32")
        XCTAssertEqual(un.displayName, "TestChannel")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "3d830f12-795c-447d-af3c-ea05e40fbddb")
        XCTAssertEqual(un.userLogin, "testchannel")
        XCTAssertEqual(un.roomId, "56379257")
        XCTAssertEqual(un.systemMessage, #"15\sraiders\sfrom\sTestChannel\shave\sjoined\n!"#)
        XCTAssertEqual(un.tmiSentTs, 1507246572675)
        XCTAssertEqual(un.userId, "123456")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.RaidInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.displayName, "TestChannel")
        XCTAssertEqual(info.login, "testchannel")
        XCTAssertEqual(info.viewerCount, 15)
        XCTAssertEqual(info.profileImageURL, "")
    }
    
    func testParsedValues5() throws {
        let string = #"@badge-info=;badges=;color=;display-name=SevenTest1;emotes=30259:0-6;id=37feed0f-b9c7-4c3a-b475-21c6c6d21c3d;login=seventest1;mod=0;msg-id=ritual;msg-param-ritual-name=new_chatter;room-id=6316121;subscriber=0;system-msg=Seventoes\sis\snew\shere!;tmi-sent-ts=1508363903826;turbo=0;user-id=131260580;user-type= :tmi.twitch.tv USERNOTICE #seventoes :HeyGuys"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "seventoes")
        XCTAssertEqual(un.message, "HeyGuys")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "SevenTest1")
        XCTAssertEqual(un.emotes, ["30259:0-6"])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "37feed0f-b9c7-4c3a-b475-21c6c6d21c3d")
        XCTAssertEqual(un.userLogin, "seventest1")
        XCTAssertEqual(un.roomId, "6316121")
        XCTAssertEqual(un.systemMessage, #"Seventoes\sis\snew\shere!"#)
        XCTAssertEqual(un.tmiSentTs, 1508363903826)
        XCTAssertEqual(un.userId, "131260580")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let ritualName: String = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(ritualName, "new_chatter")
    }
    
    func testParsedValues6() throws {
        let string = #"@badge-info=subscriber/1;badges=vip/1,subscriber/0,bits/100;color=#8A2BE2;display-name=pazza_cr4;emotes=;flags=;id=41ab23ee-4728-4f8b-9d72-8fa92300cc94;login=pazza_cr4;mod=0;msg-id=communitypayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=dillydilby;msg-param-prior-gifter-id=629935431;msg-param-prior-gifter-user-name=dillydilby;room-id=629935431;subscriber=1;system-msg=pazza_cr4\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sdillydilby\sto\sthe\scommunity!;tmi-sent-ts=1642853857868;user-id=757980712;user-type= :tmi.twitch.tv USERNOTICE #dillydilby"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dillydilby")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/1"])
        XCTAssertEqual(un.badges, ["vip/1", "subscriber/0", "bits/100"])
        XCTAssertEqual(un.color, "#8A2BE2")
        XCTAssertEqual(un.displayName, "pazza_cr4")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "41ab23ee-4728-4f8b-9d72-8fa92300cc94")
        XCTAssertEqual(un.userLogin, "pazza_cr4")
        XCTAssertEqual(un.roomId, "629935431")
        XCTAssertEqual(un.systemMessage, #"pazza_cr4\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sdillydilby\sto\sthe\scommunity!"#)
        XCTAssertEqual(un.tmiSentTs, 1642853857868)
        XCTAssertEqual(un.userId, "757980712")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.CommunityPayForwardInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.priorGifterAnonymous, false)
        XCTAssertEqual(info.priorGifterDisplayName, "dillydilby")
        XCTAssertEqual(info.priorGifterId, "629935431")
        XCTAssertEqual(info.priorGifterUserName, "dillydilby")
    }
    
    func testParsedValues7() throws {
        let string = #"@badge-info=subscriber/13;badges=subscriber/12,glitchcon2020/1;color=#1E90FF;display-name=GissihatHunger;emotes=;flags=;id=4417af02-11f7-4da8-8118-8fc2913b841c;login=gissihathunger;mod=0;msg-id=standardpayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=Benenator_007;msg-param-prior-gifter-id=609956744;msg-param-prior-gifter-user-name=benenator_007;msg-param-recipient-display-name=cuteMaggi;msg-param-recipient-id=693345558;msg-param-recipient-user-name=cutemaggi;room-id=180980116;subscriber=1;system-msg=GissihatHunger\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sBenenator_007\sto\scuteMaggi!;tmi-sent-ts=1642857017198;user-id=449423975;user-type= :tmi.twitch.tv USERNOTICE #carl_the_legend"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "carl_the_legend")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/13"])
        XCTAssertEqual(un.badges, ["subscriber/12", "glitchcon2020/1"])
        XCTAssertEqual(un.color, "#1E90FF")
        XCTAssertEqual(un.displayName, "GissihatHunger")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "4417af02-11f7-4da8-8118-8fc2913b841c")
        XCTAssertEqual(un.userLogin, "gissihathunger")
        XCTAssertEqual(un.roomId, "180980116")
        XCTAssertEqual(un.systemMessage, #"GissihatHunger\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sBenenator_007\sto\scuteMaggi!"#)
        XCTAssertEqual(un.tmiSentTs, 1642857017198)
        XCTAssertEqual(un.userId, "449423975")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.StandardPayForwardInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.priorGifterAnonymous, false)
        XCTAssertEqual(info.priorGifterDisplayName, "Benenator_007")
        XCTAssertEqual(info.priorGifterId, "609956744")
        XCTAssertEqual(info.priorGifterUserName, "benenator_007")
        XCTAssertEqual(info.recipientDisplayName, "cuteMaggi")
        XCTAssertEqual(info.recipientId, "693345558")
        XCTAssertEqual(info.recipientUserName, "cutemaggi")
    }
    
    func testParsedValues8() throws {
        let string = #"@badge-info=;badges=;color=;display-name=AnAnonymousGifter;emotes=;flags=;id=fdfebaac-e54e-44c1-b81c-95fa2f4f6c73;login=ananonymousgifter;mod=0;msg-id=subgift;msg-param-fun-string=FunStringFive;msg-param-gift-months=1;msg-param-goal-contribution-type=SUB_POINTS;msg-param-goal-current-contributions=181;msg-param-goal-description=Kochen\s+\s69;msg-param-goal-target-contributions=299;msg-param-goal-user-contributions=1;msg-param-months=4;msg-param-origin-id=21\sc2\sd1\s0d\sc9\s61\s69\sa0\s2c\s73\sad\s42\sad\s79\s60\s5e\s72\sa5\s33\s6b;msg-param-recipient-display-name=rtg_richy;msg-param-recipient-id=645584945;msg-param-recipient-user-name=rtg_richy;msg-param-sub-plan-name=Channel\sSubscription\s(dennisrlf_);msg-param-sub-plan=1000;room-id=506507314;subscriber=0;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\srtg_richy!\s;tmi-sent-ts=1643135914821;user-id=274598607;user-type= :tmi.twitch.tv USERNOTICE #dennisrlf_"#
        
        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dennisrlf_")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "AnAnonymousGifter")
        XCTAssertEqual(un.emotes, [])
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "fdfebaac-e54e-44c1-b81c-95fa2f4f6c73")
        XCTAssertEqual(un.userLogin, "ananonymousgifter")
        XCTAssertEqual(un.roomId, "506507314")
        XCTAssertEqual(un.systemMessage, #"An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\srtg_richy!\s"#)
        XCTAssertEqual(un.tmiSentTs, 1643135914821)
        XCTAssertEqual(un.userId, "274598607")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.SubGiftInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.months, 4)
        XCTAssertEqual(info.recipientDisplayName, "rtg_richy")
        XCTAssertEqual(info.recipientId, "645584945")
        XCTAssertEqual(info.recipientUserName, "rtg_richy")
        XCTAssertEqual(info.subPlan, .tier1)
        XCTAssertEqual(info.subPlanName, #"Channel\sSubscription\s(dennisrlf_)"#)
        XCTAssertEqual(info.giftMonths, 1)
        XCTAssertEqual(info.originId, #"21\sc2\sd1\s0d\sc9\s61\s69\sa0\s2c\s73\sad\s42\sad\s79\s60\s5e\s72\sa5\s33\s6b"#)
        XCTAssertEqual(info.senderCount, 0)
        XCTAssertEqual(info.funString, "FunStringFive")
        XCTAssertEqual(info.goalContributionType, "SUB_POINTS")
        XCTAssertEqual(info.goalCurrentContributions, "181")
        XCTAssertEqual(info.goalDescription, #"Kochen\s+\s69"#)
        XCTAssertEqual(info.goalTargetContributions, "299")
        XCTAssertEqual(info.goalUserContributions, "1")
    }
}

// MARK: - UserNotice.MessageID anyValue
private extension UserNotice.MessageID {
    var anyValue: Any {
        switch self {
        case let .sub(value):
            return value
        case let .resub(value):
            return value
        case let .subGift(value):
            return value
        case let .anonSubGift(value):
            return value
        case let .subMysteryGift(value):
            return value
        case let .giftPaidUpgrade(value):
            return value
        case .rewardGift:
            return "rewardGift"
        case let .anonGiftPaidUpgrade(value):
            return value
        case let .raid(value):
            return value
        case .unraid:
            return "unraid"
        case let .ritual(value):
            return value
        case let .bitsBadgeTier(value):
            return value
        case let .communityPayForward(value):
            return value
        case let .standardPayForward(value):
            return value
        }
    }
}
