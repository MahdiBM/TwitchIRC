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
            "MessageID type not expected. Available value: \(action.anyValue), Expected type: \(T.self)",
            file: file,
            line: line
        )
    }
    
    func testParsedValues1() throws {
        let string = #"@badge-info=;badges=staff/1,broadcaster/1,turbo/1;color=#008000;display-name=ronni;emotes=;id=db25007f-7a18-43eb-9379-80131e44d633;login=ronni;mod=0;msg-id=resub;msg-param-cumulative-months=6;msg-param-streak-months=2;msg-param-should-share-streak=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Prime;room-id=1337;subscriber=1;system-msg=ronni\shas\ssubscribed\sfor\s6\smonths!;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff;vip=0 :tmi.twitch.tv USERNOTICE #dallas :Great stream -- keep it up!"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dallas")
        XCTAssertEqual(un.message, "Great stream -- keep it up!")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["staff/1", "broadcaster/1", "turbo/1"])
        XCTAssertEqual(un.color, "#008000")
        XCTAssertEqual(un.displayName, "ronni")
        XCTAssertEqual(un.emotes, "")
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
        let string = #"@badge-info=;badges=staff/1,premium/1;color=#0000FF;display-name=TWW2;emotes=;id=e9176cd8-5e22-4684-ad40-ce53c2561c5e;login=tww2;mod=0;msg-id=subgift;msg-param-months=1;msg-param-recipient-display-name=Mr_Woodchuck;msg-param-recipient-id=89614178;msg-param-recipient-user-name=mr_woodchuck;msg-param-sub-plan-name=House\sof\sNyoro~n;msg-param-sub-plan=1000;room-id=19571752;subscriber=0;system-msg=TWW2\sgifted\sa\sTier\s1\ssub\sto\sMr_Woodchuck!;tmi-sent-ts=1521159445153;turbo=0;user-id=13405587;user-type=staff;vip=0 :tmi.twitch.tv USERNOTICE #forstycup"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "forstycup")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["staff/1", "premium/1"])
        XCTAssertEqual(un.color, "#0000FF")
        XCTAssertEqual(un.displayName, "TWW2")
        XCTAssertEqual(un.emotes, "")
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
        XCTAssertEqual(info.funString, "")
        XCTAssertEqual(info.giftTheme, "")
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
    }
    
    func testParsedValues3() throws {
        let string = #"@badge-info=;badges=broadcaster/1,subscriber/6;color=;display-name=qa_subs_partner;emotes=;flags=;id=b1818e3c-0005-490f-ad0a-804957ddd760;login=qa_subs_partner;mod=0;msg-id=anonsubgift;msg-param-months=3;msg-param-recipient-display-name=TenureCalculator;msg-param-recipient-id=135054130;msg-param-recipient-user-name=tenurecalculator;msg-param-sub-plan-name=t111;msg-param-sub-plan=1000;room-id=196450059;subscriber=1;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sTenureCalculator!\s;tmi-sent-ts=1542063432068;turbo=0;user-id=196450059;vip=0;user-type= :tmi.twitch.tv USERNOTICE #qa_subs_partner"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "qa_subs_partner")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["broadcaster/1", "subscriber/6"])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "qa_subs_partner")
        XCTAssertEqual(un.emotes, "")
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
        XCTAssertEqual(info.funString, "")
        XCTAssertEqual(info.giftTheme, "")
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
    }
    
    func testParsedValues4() throws {
        let string = #"@badge-info=;badges=turbo/1;color=#9ACD32;display-name=TestChannel;emotes=;id=3d830f12-795c-447d-af3c-ea05e40fbddb;login=testchannel;mod=0;msg-id=raid;msg-param-displayName=TestChannel;msg-param-login=testchannel;msg-param-viewerCount=15;room-id=56379257;subscriber=0;system-msg=15\sraiders\sfrom\sTestChannel\shave\sjoined\n!;tmi-sent-ts=1507246572675;turbo=1;user-id=123456;user-type=;vip=0 :tmi.twitch.tv USERNOTICE #othertestchannel"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "othertestchannel")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["turbo/1"])
        XCTAssertEqual(un.color, "#9ACD32")
        XCTAssertEqual(un.displayName, "TestChannel")
        XCTAssertEqual(un.emotes, "")
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
        let string = #"@badge-info=;badges=;color=;display-name=SevenTest1;emotes=30259:0-6;id=37feed0f-b9c7-4c3a-b475-21c6c6d21c3d;login=seventest1;mod=0;msg-id=ritual;msg-param-ritual-name=new_chatter;room-id=6316121;subscriber=0;system-msg=Seventoes\sis\snew\shere!;tmi-sent-ts=1508363903826;turbo=0;user-id=131260580;user-type=;vip=1 :tmi.twitch.tv USERNOTICE #seventoes :HeyGuys"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "seventoes")
        XCTAssertEqual(un.message, "HeyGuys")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "SevenTest1")
        XCTAssertEqual(un.emotes, "30259:0-6")
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
        let string = #"@badge-info=subscriber/1;badges=vip/1,subscriber/0,bits/100;color=#8A2BE2;display-name=pazza_cr4;emotes=;flags=;id=41ab23ee-4728-4f8b-9d72-8fa92300cc94;login=pazza_cr4;mod=0;msg-id=communitypayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=dillydilby;msg-param-prior-gifter-id=629935431;msg-param-prior-gifter-user-name=dillydilby;room-id=629935431;subscriber=1;system-msg=pazza_cr4\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sdillydilby\sto\sthe\scommunity!;tmi-sent-ts=1642853857868;user-id=757980712;user-type=;vip=0 :tmi.twitch.tv USERNOTICE #dillydilby"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dillydilby")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/1"])
        XCTAssertEqual(un.badges, ["vip/1", "subscriber/0", "bits/100"])
        XCTAssertEqual(un.color, "#8A2BE2")
        XCTAssertEqual(un.displayName, "pazza_cr4")
        XCTAssertEqual(un.emotes, "")
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
        let string = #"@badge-info=subscriber/13;badges=subscriber/12,glitchcon2020/1;color=#1E90FF;display-name=GissihatHunger;emotes=;flags=;id=4417af02-11f7-4da8-8118-8fc2913b841c;login=gissihathunger;mod=0;msg-id=standardpayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=Benenator_007;msg-param-prior-gifter-id=609956744;msg-param-prior-gifter-user-name=benenator_007;msg-param-recipient-display-name=cuteMaggi;msg-param-recipient-id=693345558;msg-param-recipient-user-name=cutemaggi;room-id=180980116;subscriber=1;system-msg=GissihatHunger\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sBenenator_007\sto\scuteMaggi!;tmi-sent-ts=1642857017198;user-id=449423975;user-type=;vip=1 :tmi.twitch.tv USERNOTICE #carl_the_legend"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "carl_the_legend")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/13"])
        XCTAssertEqual(un.badges, ["subscriber/12", "glitchcon2020/1"])
        XCTAssertEqual(un.color, "#1E90FF")
        XCTAssertEqual(un.displayName, "GissihatHunger")
        XCTAssertEqual(un.emotes, "")
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
        let string = #"@badge-info=;badges=;color=;display-name=AnAnonymousGifter;emotes=;flags=;id=fdfebaac-e54e-44c1-b81c-95fa2f4f6c73;login=ananonymousgifter;mod=0;msg-id=subgift;msg-param-fun-string=FunStringFive;msg-param-gift-months=1;msg-param-goal-contribution-type=SUB_POINTS;msg-param-goal-current-contributions=181;msg-param-goal-description=Kochen\s+\s69;msg-param-goal-target-contributions=299;msg-param-goal-user-contributions=1;msg-param-months=4;msg-param-origin-id=21\sc2\sd1\s0d\sc9\s61\s69\sa0\s2c\s73\sad\s42\sad\s79\s60\s5e\s72\sa5\s33\s6b;msg-param-recipient-display-name=rtg_richy;msg-param-recipient-id=645584945;msg-param-recipient-user-name=rtg_richy;msg-param-sub-plan-name=Channel\sSubscription\s(dennisrlf_);msg-param-sub-plan=1000;room-id=506507314;subscriber=0;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\srtg_richy!\s;tmi-sent-ts=1643135914821;user-id=274598607;user-type=;vip=1 :tmi.twitch.tv USERNOTICE #dennisrlf_"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "dennisrlf_")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "AnAnonymousGifter")
        XCTAssertEqual(un.emotes, "")
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
        XCTAssertEqual(info.giftTheme, "")
        XCTAssertEqual(info.goalContributionType, "SUB_POINTS")
        XCTAssertEqual(info.goalCurrentContributions, "181")
        XCTAssertEqual(info.goalDescription, #"Kochen\s+\s69"#)
        XCTAssertEqual(info.goalTargetContributions, "299")
        XCTAssertEqual(info.goalUserContributions, "1")
    }
    
    func testParsedValues9() throws {
        let string = #"@badge-info=;badges=;color=;display-name=AnAnonymousGifter;emotes=;flags=;id=a05bcefe-bcae-4421-899a-c2ed087d3174;login=ananonymousgifter;mod=0;msg-id=subgift;msg-param-fun-string=FunStringOne;msg-param-gift-months=1;msg-param-gift-theme=lul;msg-param-months=2;msg-param-origin-id=e0\sbf\sa4\s8d\se8\s49\s72\s6e\s37\s1f\s32\s62\s6c\s98\s53\s45\sf1\s34\s15\s3e;msg-param-recipient-display-name=professorlive_cr;msg-param-recipient-id=214715951;msg-param-recipient-user-name=professorlive_cr;msg-param-sub-plan-name=Juicy;msg-param-sub-plan=1000;room-id=123721524;subscriber=0;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sprofessorlive_cr!\s;tmi-sent-ts=1643495894080;user-id=274598607;vip=1;user-type= :tmi.twitch.tv USERNOTICE #juicyj_cr"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "juicyj_cr")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "AnAnonymousGifter")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "a05bcefe-bcae-4421-899a-c2ed087d3174")
        XCTAssertEqual(un.userLogin, "ananonymousgifter")
        XCTAssertEqual(un.roomId, "123721524")
        XCTAssertEqual(un.systemMessage, #"An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sprofessorlive_cr!\s"#)
        XCTAssertEqual(un.tmiSentTs, 1643495894080)
        XCTAssertEqual(un.userId, "274598607")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.SubGiftInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.months, 2)
        XCTAssertEqual(info.recipientDisplayName, "professorlive_cr")
        XCTAssertEqual(info.recipientId, "214715951")
        XCTAssertEqual(info.recipientUserName, "professorlive_cr")
        XCTAssertEqual(info.subPlan, .tier1)
        XCTAssertEqual(info.subPlanName, "Juicy")
        XCTAssertEqual(info.giftMonths, 1)
        XCTAssertEqual(info.originId, #"e0\sbf\sa4\s8d\se8\s49\s72\s6e\s37\s1f\s32\s62\s6c\s98\s53\s45\sf1\s34\s15\s3e"#)
        XCTAssertEqual(info.senderCount, 0)
        XCTAssertEqual(info.funString, "FunStringOne")
        XCTAssertEqual(info.giftTheme, "lul")
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
    }
    
    func testParsedValues10() throws {
        let string = #"@badge-info=subscriber/1;badges=subscriber/0,sub-gifter/1;color=#8422B2;display-name=ItsMeekz;emotes=;flags=;id=0f138c82-d842-4055-af48-f7a84a43461d;login=itsmeekz;mod=0;msg-id=primepaidupgrade;msg-param-sub-plan=1000;room-id=117855516;subscriber=1;system-msg=ItsMeekz\sconverted\sfrom\sa\sPrime\ssub\sto\sa\sTier\s1\ssub!;tmi-sent-ts=1643569662528;vip=1;user-id=608094265;user-type= :tmi.twitch.tv USERNOTICE #domino_stein"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "domino_stein")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/1"])
        XCTAssertEqual(un.badges, ["subscriber/0", "sub-gifter/1"])
        XCTAssertEqual(un.color, "#8422B2")
        XCTAssertEqual(un.displayName, "ItsMeekz")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "0f138c82-d842-4055-af48-f7a84a43461d")
        XCTAssertEqual(un.userLogin, "itsmeekz")
        XCTAssertEqual(un.roomId, "117855516")
        XCTAssertEqual(un.systemMessage, #"ItsMeekz\sconverted\sfrom\sa\sPrime\ssub\sto\sa\sTier\s1\ssub!"#)
        XCTAssertEqual(un.tmiSentTs, 1643569662528)
        XCTAssertEqual(un.userId, "608094265")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.PrimePaidUpgradeInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.subPlan, .tier1)
    }
    
    func testParsedValues11() throws {
        let string = #"@badge-info=subscriber/44;badges=broadcaster/1,subscriber/3036,partner/1;color=#8A2BE2;display-name=Schlonsti;emotes=;flags=;id=0d011cb5-84c9-4abf-b469-905fa48d1e73;login=schlonsti;mod=0;msg-id=announcement;msg-param-color=PRIMARY;room-id=90968980;subscriber=1;system-msg=;tmi-sent-ts=1648760291007;user-id=90968980;vip=1;user-type= :tmi.twitch.tv USERNOTICE #schlonsti :fehler"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "schlonsti")
        XCTAssertEqual(un.message, "fehler")
        XCTAssertEqual(un.badgeInfo, ["subscriber/44"])
        XCTAssertEqual(un.badges, ["broadcaster/1", "subscriber/3036", "partner/1"])
        XCTAssertEqual(un.color, "#8A2BE2")
        XCTAssertEqual(un.displayName, "Schlonsti")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "0d011cb5-84c9-4abf-b469-905fa48d1e73")
        XCTAssertEqual(un.userLogin, "schlonsti")
        XCTAssertEqual(un.roomId, "90968980")
        XCTAssertEqual(un.systemMessage, "")
        XCTAssertEqual(un.tmiSentTs, 1648760291007)
        XCTAssertEqual(un.userId, "90968980")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let infoColor: String = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(infoColor, "PRIMARY")
    }
    
    func testParsedValues12() throws {
        let string = #"@badge-info=;badges=;color=#DAA520;display-name=LF_patocarlo_papi;emotes=;flags=;id=9734d325-603f-42a8-a728-2032943d1786;login=lf_patocarlo_papi;mod=0;msg-id=midnightsquid;msg-param-amount=100;msg-param-currency=USD;msg-param-emote-id=emotesv2_630d12043c5d40dc97a1f8deac5842f1;msg-param-exponent=2;msg-param-is-highlighted=false;msg-param-pill-type=Success;room-id=473386056;subscriber=0;system-msg=LF_patocarlo_papi\\sCheered\\swith\\s$1.00;tmi-sent-ts=1664487028027;user-id=494211968;vip=1;user-type= :tmi.twitch.tv USERNOTICE #jandrotc"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "jandrotc")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, [])
        XCTAssertEqual(un.color, "#DAA520")
        XCTAssertEqual(un.displayName, "LF_patocarlo_papi")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "9734d325-603f-42a8-a728-2032943d1786")
        XCTAssertEqual(un.userLogin, "lf_patocarlo_papi")
        XCTAssertEqual(un.roomId, "473386056")
        XCTAssertEqual(un.systemMessage, #"LF_patocarlo_papi\\sCheered\\swith\\s$1.00"#)
        XCTAssertEqual(un.tmiSentTs, 1664487028027)
        XCTAssertEqual(un.userId, "494211968")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.MidnightSquidInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.amount, 100)
        XCTAssertEqual(info.currency, "USD")
        XCTAssertEqual(info.emoteId, "emotesv2_630d12043c5d40dc97a1f8deac5842f1")
        XCTAssertEqual(info.exponent, 2)
        XCTAssertEqual(info.isHighlighted, false)
        XCTAssertEqual(info.pillType, "Success")
    }
    
    func testParsedValues13() throws {
        let string = #"@badge-info=;badges=premium/1;color=#9ACD32;display-name=LukeCaboom;emotes=;flags=;id=479defa1-dac0-47e6-b308-a19c2a8b64cd;login=lukecaboom;mod=0;msg-id=charitydonation;msg-param-charity-name=Wounded\\sWarrior\\sProject;msg-param-donation-amount=500;msg-param-donation-currency=USD;msg-param-exponent=2;room-id=18798485;subscriber=0;system-msg=LukeCaboom:\\sDonated\\sUSD\\s5\\sto\\ssupport\\sWounded\\sWarrior\\sProject;tmi-sent-ts=1664727225702;user-id=514556756;vip=1;user-type= :tmi.twitch.tv USERNOTICE #fxyen"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "fxyen")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, [])
        XCTAssertEqual(un.badges, ["premium/1"])
        XCTAssertEqual(un.color, "#9ACD32")
        XCTAssertEqual(un.displayName, "LukeCaboom")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "479defa1-dac0-47e6-b308-a19c2a8b64cd")
        XCTAssertEqual(un.userLogin, "lukecaboom")
        XCTAssertEqual(un.roomId, "18798485")
        XCTAssertEqual(
            un.systemMessage,
            #"LukeCaboom:\\sDonated\\sUSD\\s5\\sto\\ssupport\\sWounded\\sWarrior\\sProject"#
        )
        XCTAssertEqual(un.tmiSentTs, 1664727225702)
        XCTAssertEqual(un.userId, "514556756")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.CharityDonationInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.charityName, #"Wounded\\sWarrior\\sProject"#)
        XCTAssertEqual(info.amount, 500)
        XCTAssertEqual(info.currency, "USD")
        XCTAssertEqual(info.exponent, 2)
    }
    
    func testParsedValues14() throws {
        let string = #"@badge-info=founder/12;badges=moderator/1,founder/0,hype-train/1;color=#0000FF;display-name=metalkiller354;emotes=;flags=;id=aa1d37a5-e0d0-40b2-b374-ae779896a6f9;login=metalkiller354;mod=1;msg-id=viewermilestone;msg-param-category=watch-streak;msg-param-id=f05b2393-3bee-451c-bcb2-d12ea06781d7;msg-param-value=3;room-id=442187430;msg-param-copoReward=450;subscriber=1;system-msg=metalkiller354\\swatched\\s3\\sconsecutive\\sstreams\\sthis\\smonth\\sand\\ssparked\\sa\\swatch\\sstreak!;tmi-sent-ts=1678130127599;user-id=224637183;vip=1;user-type=mod :tmi.twitch.tv USERNOTICE #tryaz"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)
        
        XCTAssertEqual(un.channel, "tryaz")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["founder/12"])
        XCTAssertEqual(un.badges, ["moderator/1", "founder/0", "hype-train/1"])
        XCTAssertEqual(un.color, "#0000FF")
        XCTAssertEqual(un.displayName, "metalkiller354")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "aa1d37a5-e0d0-40b2-b374-ae779896a6f9")
        XCTAssertEqual(un.userLogin, "metalkiller354")
        XCTAssertEqual(un.roomId, "442187430")
        XCTAssertEqual(
            un.systemMessage,
            #"metalkiller354\\swatched\\s3\\sconsecutive\\sstreams\\sthis\\smonth\\sand\\ssparked\\sa\\swatch\\sstreak!"#
        )
        XCTAssertEqual(un.tmiSentTs, 1678130127599)
        XCTAssertEqual(un.userId, "224637183")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")
        
        let info: Action.ViewerMilestoneInfo = try unwrapInnerValue(action: un.messageId)
        
        XCTAssertEqual(info.category, "watch-streak")
        XCTAssertEqual(info.id, "f05b2393-3bee-451c-bcb2-d12ea06781d7")
        XCTAssertEqual(info.value, 3)
        XCTAssertEqual(info.copoReward, 450)
    }

    func testParsedValues15() throws {
        let string = #"@badge-info=subscriber/5;badges=subscriber/3,sub-gifter/10;color=;display-name=EABare;emotes=;flags=;id=aadbe3eb-7d44-46d9-a596-d2d45dbe5f68;login=eabare;mod=0;msg-id=subgift;msg-param-community-gift-id=b9\\s31\\s3e\\s61\\s1f\\s74\\sa1\\s59\\scc\\sa1\\sb7\\s96\\sbb\\sdb\\s8c\\s10\\sd9\\s90\\s68\\sea;msg-param-gift-months=1;msg-param-months=9;msg-param-origin-id=b9\\s31\\s3e\\s61\\s1f\\s74\\sa1\\s59\\scc\\sa1\\sb7\\s96\\sbb\\sdb\\s8c\\s10\\sd9\\s90\\s68\\sea;msg-param-recipient-display-name=josefernandezxc;msg-param-recipient-id=497056606;msg-param-recipient-user-name=josefernandezxc;msg-param-sender-count=0;msg-param-sub-plan-name=Channel\\sSubscription\\s(zsheli);msg-param-sub-plan=1000;room-id=54443609;subscriber=1;system-msg=EABare\\sgifted\\sa\\sTier\\s1\\ssub\\sto\\sjosefernandezxc!;tmi-sent-ts=1699496601758;user-id=816456923;user-type=;vip=0 :tmi.twitch.tv USERNOTICE #shellive"#

        let un: UserNotice = try TestUtils.parseAndUnwrap(string: string)

        XCTAssertEqual(un.channel, "shellive")
        XCTAssertEqual(un.message, "")
        XCTAssertEqual(un.badgeInfo, ["subscriber/5"])
        XCTAssertEqual(un.badges, ["subscriber/3", "sub-gifter/10"])
        XCTAssertEqual(un.color, "")
        XCTAssertEqual(un.displayName, "EABare")
        XCTAssertEqual(un.emotes, "")
        XCTAssertEqual(un.flags, [])
        XCTAssertEqual(un.id, "aadbe3eb-7d44-46d9-a596-d2d45dbe5f68")
        XCTAssertEqual(un.userLogin, "eabare")
        XCTAssertEqual(un.roomId, "54443609")
        XCTAssertEqual(
            un.systemMessage,
            #"EABare\\sgifted\\sa\\sTier\\s1\\ssub\\sto\\sjosefernandezxc!"#
        )
        XCTAssertEqual(un.tmiSentTs, 1699496601758)
        XCTAssertEqual(un.userId, "816456923")
        XCTAssertTrue(un.parsingLeftOvers.isEmpty, "Non-empty parsing left-overs: \(un.parsingLeftOvers)")

        let info: Action.SubGiftInfo = try unwrapInnerValue(action: un.messageId)

        XCTAssertEqual(info.months, 9)
        XCTAssertEqual(info.recipientDisplayName, "josefernandezxc")
        XCTAssertEqual(info.recipientId, "497056606")
        XCTAssertEqual(info.recipientUserName, "josefernandezxc")
        XCTAssertEqual(info.subPlan, .tier1)
        XCTAssertEqual(info.subPlanName, #"Channel\\sSubscription\\s(zsheli)"#)
        XCTAssertEqual(info.giftMonths, 1)
        XCTAssertEqual(info.originId, #"b9\\s31\\s3e\\s61\\s1f\\s74\\sa1\\s59\\scc\\sa1\\sb7\\s96\\sbb\\sdb\\s8c\\s10\\sd9\\s90\\s68\\sea"#)
        XCTAssertEqual(info.senderCount, 0)
        XCTAssertEqual(info.funString, "")
        XCTAssertEqual(info.giftTheme, "")
        XCTAssertEqual(info.goalContributionType, "")
        XCTAssertEqual(info.goalCurrentContributions, "")
        XCTAssertEqual(info.goalDescription, "")
        XCTAssertEqual(info.goalTargetContributions, "")
        XCTAssertEqual(info.goalUserContributions, "")
        XCTAssertEqual(info.communityGiftId, #"b9\\s31\\s3e\\s61\\s1f\\s74\\sa1\\s59\\scc\\sa1\\sb7\\s96\\sbb\\sdb\\s8c\\s10\\sd9\\s90\\s68\\sea"#)
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
        case let .primePaidUpgrade(value):
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
        case let .announcement(color):
            return color as Any
        case let .midnightSquid(value):
            return value
        case let .charityDonation(value):
            return value
        case let .viewerMilestone(value):
            return value
        }
    }
}
