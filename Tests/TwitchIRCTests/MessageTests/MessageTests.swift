@testable import TwitchIRC
import XCTest

final class IncomingMessagesTests: XCTestCase {
    
    func testFindingCorrectMessageCase() throws {
        
        // connectionNotice
        do {
            let string = ":tmi.twitch.tv 001 royalealchemist :Welcome, GLHF!\r\n:tmi.twitch.tv 002 royalealchemist :Your host is tmi.twitch.tv\r\n:tmi.twitch.tv 003 royalealchemist :This server is rather new\r\n:tmi.twitch.tv 004 royalealchemist :-\r\n:tmi.twitch.tv 375 royalealchemist :-\r\n:tmi.twitch.tv 372 royalealchemist :You are in a maze of twisty passages, all alike.\r\n:tmi.twitch.tv 376 royalealchemist :>"
            let messages = Message.parse(ircOutput: string)
            for message in messages {
                switch message {
                case .connectionNotice: break
                default:
                    XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
                }
            }
        }
        
        // channelEntrance
        do {
            let string = ":royalealchemist.tmi.twitch.tv 353 royalealchemist = #fxyen :royalealchemist\r\n:royalealchemist.tmi.twitch.tv 366 royalealchemist #fxyen :End of /NAMES list"
            let messages = Message.parse(ircOutput: string)
            for message in messages {
                switch message {
                case .channelEntrance: break
                default:
                    XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
                }
            }
        }
        
        // globalUserState
        do {
            let string = "@badge-info=subscriber/8;badges=subscriber/6;color=#0D4200;display-name=dallas;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;turbo=0;user-id=1337;user-type=admin :tmi.twitch.tv GLOBALUSERSTATE"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .globalUserState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // privateMessage
        do {
            let string = "@badge-info=;badges=global_mod/1,turbo/1;color=#0D4200;display-name=ronni;emotes=25:0-4,12-16/1902:6-10;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=global_mod :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :Kappa Keepo Kappa"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .privateMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // privateMessage 2
        do {
            let string = "@badge-info=;badges=staff/1,bits/1000;bits=100;color=;display-name=ronni;emotes=;id=b34ccfc7-4977-403a-8a94-33c6bac34fb8;mod=0;room-id=1337;subscriber=0;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :ronni!ronni@ronni.tmi.twitch.tv PRIVMSG #ronni :cheer100"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .privateMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // privateMessage 3
        do {
            // has a weird character at the end.
            let string = "@badge-info=;badges=;client-nonce=3dc1eef952878c31098361ebfc5017d7;color=;display-name=littlesnakysnake;emotes=;first-msg=0;flags=;id=9a323937-80fe-442a-b3a9-8c32e37cfb4f;mod=0;room-id=180980116;subscriber=0;tmi-sent-ts=1642848914241;turbo=0;user-id=478769067;user-type= :littlesnakysnake!littlesnakysnake@littlesnakysnake.tmi.twitch.tv PRIVMSG #carl_the_legend :ّ"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .privateMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // join
        do {
            let string = ":ronni!ronni@ronni.tmi.twitch.tv JOIN #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .join: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // part
        do {
            let string = ":ronni!ronni@ronni.tmi.twitch.tv PART #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .part: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat
        do {
            let string = ":tmi.twitch.tv CLEARCHAT #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat 2
        do {
            let string = ":tmi.twitch.tv CLEARCHAT #dallas :ronni"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearChat 3
        do {
            let string = "@ban-duration=3600 :tmi.twitch.tv CLEARCHAT #goodvibes :toxicity"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearChat: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // clearMessage
        do {
            let string = "@login=ronni;target-msg-id=abc-123-def;room-id=;tmi-sent-ts=1642860513538 :tmi.twitch.tv CLEARMSG #dallas :HeyGuys"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .clearMessage: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch 1"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 2
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :- 130"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 3
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :twitch"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // hostTarget 4
        do {
            let string = ":tmi.twitch.tv HOSTTARGET #twitchdev :-"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .hostTarget: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // reconnect
        do {
            let string = ":tmi.twitch.tv RECONNECT"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .reconnect: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // roomState
        do {
            let string = "@emote-only=0;followers-only=0;r9k=0;slow=0;subs-only=0 :tmi.twitch.tv ROOMSTATE #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .roomState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice
        do {
            let string = #"@badge-info=;badges=staff/1,broadcaster/1,turbo/1;color=#008000;display-name=ronni;emotes=;id=db25007f-7a18-43eb-9379-80131e44d633;login=ronni;mod=0;msg-id=resub;msg-param-cumulative-months=6;msg-param-streak-months=2;msg-param-should-share-streak=1;msg-param-sub-plan=Prime;msg-param-sub-plan-name=Prime;room-id=1337;subscriber=1;system-msg=ronni\shas\ssubscribed\sfor\s6\smonths!;tmi-sent-ts=1507246572675;turbo=1;user-id=1337;user-type=staff :tmi.twitch.tv USERNOTICE #dallas :Great stream -- keep it up!"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 2
        do {
            let string = #"@badge-info=;badges=staff/1,premium/1;color=#0000FF;display-name=TWW2;emotes=;id=e9176cd8-5e22-4684-ad40-ce53c2561c5e;login=tww2;mod=0;msg-id=subgift;msg-param-months=1;msg-param-recipient-display-name=Mr_Woodchuck;msg-param-recipient-id=89614178;msg-param-recipient-name=mr_woodchuck;msg-param-sub-plan-name=House\sof\sNyoro~n;msg-param-sub-plan=1000;room-id=19571752;subscriber=0;system-msg=TWW2\sgifted\sa\sTier\s1\ssub\sto\sMr_Woodchuck!;tmi-sent-ts=1521159445153;turbo=0;user-id=13405587;user-type=staff :tmi.twitch.tv USERNOTICE #forstycup"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 3
        do {
            let string = #"@badge-info=;badges=broadcaster/1,subscriber/6;color=;display-name=qa_subs_partner;emotes=;flags=;id=b1818e3c-0005-490f-ad0a-804957ddd760;login=qa_subs_partner;mod=0;msg-id=anonsubgift;msg-param-months=3;msg-param-recipient-display-name=TenureCalculator;msg-param-recipient-id=135054130;msg-param-recipient-user-name=tenurecalculator;msg-param-sub-plan-name=t111;msg-param-sub-plan=1000;room-id=196450059;subscriber=1;system-msg=An\sanonymous\suser\sgifted\sa\sTier\s1\ssub\sto\sTenureCalculator!\s;tmi-sent-ts=1542063432068;turbo=0;user-id=196450059;user-type= :tmi.twitch.tv USERNOTICE #qa_subs_partner"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 4
        do {
            let string = #"@badge-info=;badges=turbo/1;color=#9ACD32;display-name=TestChannel;emotes=;id=3d830f12-795c-447d-af3c-ea05e40fbddb;login=testchannel;mod=0;msg-id=raid;msg-param-displayName=TestChannel;msg-param-login=testchannel;msg-param-viewerCount=15;room-id=56379257;subscriber=0;system-msg=15\sraiders\sfrom\sTestChannel\shave\sjoined\n!;tmi-sent-ts=1507246572675;tmi-sent-ts=1507246572675;turbo=1;user-id=123456;user-type= :tmi.twitch.tv USERNOTICE #othertestchannel"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 5
        do {
            let string = #"@badge-info=;badges=;color=;display-name=SevenTest1;emotes=30259:0-6;id=37feed0f-b9c7-4c3a-b475-21c6c6d21c3d;login=seventest1;mod=0;msg-id=ritual;msg-param-ritual-name=new_chatter;room-id=6316121;subscriber=0;system-msg=Seventoes\sis\snew\shere!;tmi-sent-ts=1508363903826;turbo=0;user-id=131260580;user-type= :tmi.twitch.tv USERNOTICE #seventoes :HeyGuys"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 6
        do {
            let string = #"@badge-info=subscriber/1;badges=vip/1,subscriber/0,bits/100;color=#8A2BE2;display-name=pazza_cr4;emotes=;flags=;id=41ab23ee-4728-4f8b-9d72-8fa92300cc94;login=pazza_cr4;mod=0;msg-id=communitypayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=dillydilby;msg-param-prior-gifter-id=629935431;msg-param-prior-gifter-user-name=dillydilby;room-id=629935431;subscriber=1;system-msg=pazza_cr4\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sdillydilby\sto\sthe\scommunity!;tmi-sent-ts=1642853857868;user-id=757980712;user-type= :tmi.twitch.tv USERNOTICE #dillydilby"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userNotice 7
        do {
            let string = #"@badge-info=subscriber/13;badges=subscriber/12,glitchcon2020/1;color=#1E90FF;display-name=GissihatHunger;emotes=;flags=;id=4417af02-11f7-4da8-8118-8fc2913b841c;login=gissihathunger;mod=0;msg-id=standardpayforward;msg-param-prior-gifter-anonymous=false;msg-param-prior-gifter-display-name=Benenator_007;msg-param-prior-gifter-id=609956744;msg-param-prior-gifter-user-name=benenator_007;msg-param-recipient-display-name=cuteMaggi;msg-param-recipient-id=693345558;msg-param-recipient-user-name=cutemaggi;room-id=180980116;subscriber=1;system-msg=GissihatHunger\sis\spaying\sforward\sthe\sGift\sthey\sgot\sfrom\sBenenator_007\sto\scuteMaggi!;tmi-sent-ts=1642857017198;user-id=449423975;user-type= :tmi.twitch.tv USERNOTICE #carl_the_legend"#
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userNotice: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // userState
        do {
            let string = "@badge-info=;badges=staff/1;color=#0D4200;display-name=ronni;emote-sets=0,33,50,237,793,2126,3517,4578,5569,9400,10337,12239;mod=1;subscriber=1;turbo=1;user-type=staff :tmi.twitch.tv USERSTATE #dallas"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .userState: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // capabilities
        do {
            let string = ":tmi.twitch.tv CAP * ACK :twitch.tv/tags twitch.tv/commands"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .capabilities: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // whisper
        do {
            let string = "@badges=;color=;display-name=drizzlepickles;emotes=;message-id=1;thread-id=684111155_699948886;turbo=0;user-id=699948886;user-type= :drizzlepickles!drizzlepickles@drizzlepickles.tmi.twitch.tv WHISPER royalealchemist :stop sir"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .whisper: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // whisper 2
        do {
            let string = "@badges=;color=#1E90FF;display-name=MahdiMMBM;emotes=30259:0-6,8-14;message-id=3;thread-id=519827148_684111155;turbo=0;user-id=519827148;user-type= :mahdimmbm!mahdimmbm@mahdimmbm.tmi.twitch.tv WHISPER royalealchemist :HeyGuys HeyGuys"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .whisper: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // ping
        do {
            let string = "PING :tmi.twitch.tv"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .ping: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // pong
        do {
            let string = "PONG :tmi.twitch.tv"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .pong: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
        // unknown
        do {
            let string = "efnoiewnfoanfoas dna na faonfa"
            let messages = Message.parse(ircOutput: string)
            switch messages.first {
            case .unknown: break
            default:
                XCTFail("Wrong message case parsed. Message: \(string.debugDescription), Parsed: \(messages)")
            }
        }
        
    }
    
}
