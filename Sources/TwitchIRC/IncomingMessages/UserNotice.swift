
/// A Twitch `USERNOTICE` message.
public struct UserNotice {
    
    public enum Action {
        
        public enum SubPlan: String {
            case followersTier = ""
            case tier1 = "1000"
            case tier2 = "2000"
            case tier3 = "3000"
            case prime = "Prime"
        }
        
        public struct SubInfo {
            public var cumulativeMonths: UInt
            public var shouldShareStreak: Bool
            public var streakMonths: UInt
            public var subPlan: SubPlan?
            public var subPlanName: String
            public var months: UInt
            public var multimonthDuration: UInt
            public var multimonthTenure: Bool
            public var wasGifted: Bool
        }
        
        public struct SubGiftInfo {
            public var months: UInt
            public var recipientDisplayName: String
            public var recipientId: String
            public var recipientUserName: String
            public var subPlan: SubPlan?
            public var subPlanName: String
            public var giftMonths: UInt
            public var originId: String
            public var senderCount: UInt
        }
        
        public struct GiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
            public var senderLogin: String
            public var senderName: String
        }
        
        public struct AnonGiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
        }
        
        public struct RaidInfo {
            public var displayName: String
            public var login: String
            public var viewerCount: UInt
        }
        
        public struct CommunityPayForwardInfo {
            public var priorGifterAnonymous: Bool
            public var priorGifterDisplayName: String
            public var priorGifterId: String
            public var priorGifterUserName: String
        }
        
        public struct StandardPayForwardInfo {
            public var priorGifterAnonymous: Bool
            public var priorGifterDisplayName: String
            public var priorGifterId: String
            public var priorGifterUserName: String
            public var recipientDisplayName: String
            public var recipientId: String
            public var recipientUserName: String
        }
        
        case sub(SubInfo)
        case resub(SubInfo)
        case subGift(SubGiftInfo)
        case anonSubGift(SubGiftInfo)
        case subMysteryGift
        case giftPaidUpgrade(GiftPaidUpgradeInfo)
        case rewardGift
        case anonGiftPaidUpgrade(AnonGiftPaidUpgradeInfo)
        case raid(RaidInfo)
        case unraid
        case ritual(name: String)
        case bitsBadgeTier(threshold: String)
        case communityPayForward(CommunityPayForwardInfo)
        case standardPayForward(StandardPayForwardInfo)
    }
    
    /// Channel lowercased name.
    public var channel = String()
    /// Possible message sent by user.
    public var message = String()
    /// User's badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with upper/lower-case letters.
    public var displayName = String()
    /// User's emotes.
    public var emotes = [String]()
    /// Flags of this notice.
    public var flags = [String]()
    /// Message's id.
    public var id = String()
    /// User's lowercased name.
    public var login = String()
    /// More-precise info about this user notice.
    public var msgId: Action!
    /// Broadcaster's Twitch identifier.
    public var roomId = String()
    /// System's description of this message.
    public var systemMessage = String()
    /// The timestamp of the message.
    public var tmiSentTs = UInt()
    /// User's Twitch identifier.
    public var userId = String()
    /// Remaining unhandled info in the message. Optimally empty.
    public var unknownStorage = [(lhs: String, rhs: String)]()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#", contentLhs.count > 2 else {
            return nil
        }
        
        if let (channel, message) = String(contentRhs.dropFirst()).componentsOneSplit(
            separatedBy: " "
        ) {
            self.channel = channel
            /// `dropFirst` to remove ":", `componentsOneSplit(separatedBy: " :")` fails in
            /// rare cases where user inputs weird chars. One case is included in
            /// tests of `privateMessage`.
            self.message = String(message.dropFirst())
        } else {
            self.channel = String(contentRhs.dropFirst())
        }
        
        let container = String(contentLhs.dropLast(2))
            .components(separatedBy: ";")
            .compactMap({ $0.componentsOneSplit(separatedBy: "=") })
        
        var usedIndices = [Int]()
        
        func get(for key: String) -> String {
            if let idx = container.firstIndex(where: { $0.lhs == key }) {
                usedIndices.append(idx)
                return container[idx].rhs
            } else {
                return ""
            }
        }
        
        func asArray(_ string: String) -> [String] {
            string.components(separatedBy: ",").filter({ !$0.isEmpty })
        }
        
        func asBool(_ string: String) -> Bool {
            string == "1"
        }
        
        func asUInt(_ string: String) -> UInt {
            UInt(string) ?? 0
        }
        
        func asRepresentable<R>(_ string: String) -> R?
        where R: RawRepresentable, R.RawValue == String {
            .init(rawValue: string)
        }
        
        switch get(for: "msg-id") {
        case "sub":
            self.msgId = .sub(.init(
                cumulativeMonths: asUInt(get(for: "msg-param-cumulative-months")),
                shouldShareStreak: asBool(get(for: "msg-param-should-share-streak")),
                streakMonths: asUInt(get(for: "msg-param-streak-months")),
                subPlan: asRepresentable(get(for: "msg-param-sub-plan")),
                subPlanName: get(for: "msg-param-sub-plan-name"),
                months: asUInt(get(for: "msg-param-months")),
                multimonthDuration: asUInt(get(for: "msg-param-multimonth-duration")),
                multimonthTenure: asBool(get(for: "msg-param-multimonth-tenure")),
                wasGifted: asBool(get(for: "msg-param-was-gifted"))
            ))
        case "resub":
            self.msgId = .resub(.init(
                cumulativeMonths: asUInt(get(for: "msg-param-cumulative-months")),
                shouldShareStreak: asBool(get(for: "msg-param-should-share-streak")),
                streakMonths: asUInt(get(for: "msg-param-streak-months")),
                subPlan: asRepresentable(get(for: "msg-param-sub-plan")),
                subPlanName: get(for: "msg-param-sub-plan-name"),
                months: asUInt(get(for: "msg-param-months")),
                multimonthDuration: asUInt(get(for: "msg-param-multimonth-duration")),
                multimonthTenure: asBool(get(for: "msg-param-multimonth-tenure")),
                wasGifted: asBool(get(for: "msg-param-was-gifted"))
            ))
        case "subgift":
            self.msgId = .subGift(.init(
                months: asUInt(get(for: "msg-param-months")),
                recipientDisplayName: get(for: "msg-param-recipient-display-name"),
                recipientId: get(for: "msg-param-recipient-id"),
                recipientUserName: get(for: "msg-param-recipient-user-name"),
                subPlan: asRepresentable(get(for: "msg-param-sub-plan")),
                subPlanName: get(for: "msg-param-sub-plan-name"),
                giftMonths: asUInt(get(for: "msg-param-gift-months")),
                originId: get(for: "msg-param-origin-id"),
                senderCount: asUInt(get(for: "msg-param-sender-count"))
            ))
        case "anonsubgift":
            self.msgId = .anonSubGift(.init(
                months: asUInt(get(for: "msg-param-months")),
                recipientDisplayName: get(for: "msg-param-recipient-display-name"),
                recipientId: get(for: "msg-param-recipient-id"),
                recipientUserName: get(for: "msg-param-recipient-user-name"),
                subPlan: asRepresentable(get(for: "msg-param-sub-plan")),
                subPlanName: get(for: "msg-param-sub-plan-name"),
                giftMonths: asUInt(get(for: "msg-param-gift-months")),
                originId: get(for: "msg-param-origin-id"),
                senderCount: asUInt(get(for: "msg-param-sender-count"))
            ))
        case "submysterygift":
            self.msgId = .subMysteryGift
        case "giftpaidupgrade":
            self.msgId = .giftPaidUpgrade(.init(
                promoGiftTotal: asUInt(get(for: "msg-param-promo-gift-total")),
                promoName: get(for: "msg-param-promo-name"),
                senderLogin: get(for: "msg-param-sender-login"),
                senderName: get(for: "msg-param-sender-name")
            ))
        case "rewardgift":
            self.msgId = .rewardGift
        case "anongiftpaidupgrade":
            self.msgId = .anonGiftPaidUpgrade(.init(
                promoGiftTotal: asUInt(get(for: "msg-param-promo-gift-total")),
                promoName: get(for: "msg-param-promo-name")
            ))
        case "raid":
            self.msgId = .raid(.init(
                displayName: get(for: "msg-param-displayName"),
                login: get(for: "msg-param-login"),
                viewerCount: asUInt(get(for: "msg-param-viewerCount"))
            ))
        case "unraid":
            self.msgId = .unraid
        case "ritual":
            self.msgId = .ritual(
                name: get(for: "msg-param-ritual-name")
            )
        case "bitsbadgetier":
            self.msgId = .bitsBadgeTier(
                threshold: get(for: "msg-param-threshold")
            )
        case "communitypayforward":
            self.msgId = .communityPayForward(.init(
                priorGifterAnonymous: asBool(get(for: "msg-param-prior-gifter-anonymous")),
                priorGifterDisplayName: get(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: get(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: get(for: "msg-param-prior-gifter-user-name")
            ))
        case "standardpayforward":
            self.msgId = .standardPayForward(.init(
                priorGifterAnonymous: asBool(get(for: "msg-param-prior-gifter-anonymous")),
                priorGifterDisplayName: get(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: get(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: get(for: "msg-param-prior-gifter-user-name"),
                recipientDisplayName: get(for: "msg-param-recipient-display-name"),
                recipientId: get(for: "msg-param-recipient-id"),
                recipientUserName: get(for: "msg-param-recipient-user-name")
            ))
        default: return nil
        }
        
        self.badgeInfo = asArray(get(for: "@badge-info"))
        self.badges = asArray(get(for: "badges"))
        self.color = get(for: "color")
        self.displayName = get(for: "display-name")
        self.emotes = asArray(get(for: "emotes"))
        self.flags = asArray(get(for: "flags"))
        self.id = get(for: "id")
        self.login = get(for: "login")
        self.roomId = get(for: "room-id")
        self.systemMessage = get(for: "system-msg")
        self.tmiSentTs = UInt(get(for: "tmi-sent-ts")) ?? 0
        self.userId = get(for: "user-id")
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        self.unknownStorage = container.enumerated().filter({
            offset, element in
            !usedIndices.contains(offset) &&
            !deprecatedKeys.contains(element.lhs)
        }).map(\.element)
    }
    
}
