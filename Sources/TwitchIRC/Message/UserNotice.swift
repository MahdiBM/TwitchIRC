
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
            public var goalContributionType: String
            public var goalCurrentContributions: String
            public var goalDescription: String
            public var goalTargetContributions: String
            public var goalUserContributions: String
        }
        
        public struct ReSubInfo {
            public var cumulativeMonths: UInt
            public var shouldShareStreak: Bool
            public var streakMonths: UInt
            public var subPlan: SubPlan?
            public var subPlanName: String
            public var anonGift: Bool
            public var months: UInt
            public var multimonthDuration: UInt
            public var multimonthTenure: Bool
            public var wasGifted: Bool
            public var giftMonthBeingRedeemed: UInt
            public var giftMonths: UInt
            public var gifterId: String
            public var gifterLogin: String
            public var gifterName: String
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
            public var goalContributionType: String
            public var goalCurrentContributions: String
            public var goalDescription: String
            public var goalTargetContributions: String
            public var goalUserContributions: String
        }
        
        public struct GiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
            public var senderLogin: String
            public var senderName: String
        }
        
        public struct SubMysteryGiftInfo {
            public var massGiftCount: UInt
            public var originId: String
            public var senderCount: UInt
            public var subPlan: SubPlan?
            public var goalContributionType: String
            public var goalCurrentContributions: String
            public var goalDescription: String
            public var goalTargetContributions: String
            public var goalUserContributions: String
            public var giftTheme: String
        }
        
        public struct AnonGiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
        }
        
        public struct RaidInfo {
            public var displayName: String
            public var login: String
            public var viewerCount: UInt
            public var profileImageURL: String
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
        case resub(ReSubInfo)
        case subGift(SubGiftInfo)
        case anonSubGift(SubGiftInfo)
        case subMysteryGift(SubMysteryGiftInfo)
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
    public var userLogin = String()
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
    /// Contains info about unused info and parsing problems.
    public var parsingLeftOvers = ParsingLeftOvers()
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentRhs.first == "#", contentLhs.count > 2 else {
            return nil
        }
        
        if let (channel, message) = String(contentRhs.dropFirst()).componentsOneSplit(
            separatedBy: " "
        ) {
            self.channel = channel
            /// `.unicodeScalars.dropFirst()` to remove ":", `componentsOneSplit(separatedBy: " :")`
            /// normal methods like a simple `.dropFirst()` fail in rare cases.
            /// Remove `.unicodeScalars` in `PrivateMessage`'s `message` and run tests to find out.
            self.message = String(message.unicodeScalars.dropFirst())
        } else {
            self.channel = String(contentRhs.dropFirst())
        }
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        let occasionalSubDependentKeys: [String]
        
        switch parser.optionalString(for: "msg-id") {
        case "sub":
            self.msgId = .sub(.init(
                cumulativeMonths: parser.uint(for: "msg-param-cumulative-months"),
                shouldShareStreak: parser.bool(for: "msg-param-should-share-streak"),
                streakMonths: parser.uint(for: "msg-param-streak-months"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                months: parser.uint(for: "msg-param-months"),
                multimonthDuration: parser.uint(for: "msg-param-multimonth-duration"),
                multimonthTenure: parser.bool(for: "msg-param-multimonth-tenure"),
                wasGifted: parser.bool(for: "msg-param-was-gifted"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions")
            ))
            occasionalSubDependentKeys = ["msg-param-streak-months", "msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"]
        case "resub":
            self.msgId = .resub(.init(
                cumulativeMonths: parser.uint(for: "msg-param-cumulative-months"),
                shouldShareStreak: parser.bool(for: "msg-param-should-share-streak"),
                streakMonths: parser.uint(for: "msg-param-streak-months"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                anonGift: parser.bool(for: "msg-param-anon-gift"),
                months: parser.uint(for: "msg-param-months"),
                multimonthDuration: parser.uint(for: "msg-param-multimonth-duration"),
                multimonthTenure: parser.bool(for: "msg-param-multimonth-tenure"),
                wasGifted: parser.bool(for: "msg-param-was-gifted"),
                giftMonthBeingRedeemed: parser.uint(for: "msg-param-gift-month-being-redeemed"),
                giftMonths: parser.uint(for: "msg-param-gift-months"),
                gifterId: parser.string(for: "msg-param-gifter-id"),
                gifterLogin: parser.string(for: "msg-param-gifter-login"),
                gifterName: parser.string(for: "msg-param-gifter-name")
            ))
            occasionalSubDependentKeys = ["msg-param-streak-months", "msg-param-anon-gift", "msg-param-gift-month-being-redeemed", "msg-param-gift-months", "msg-param-gifter-id", "msg-param-gifter-login", "msg-param-gifter-name"]
        case "subgift":
            self.msgId = .subGift(.init(
                months: parser.uint(for: "msg-param-months"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                giftMonths: parser.uint(for: "msg-param-gift-months"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions")
            ))
            occasionalSubDependentKeys = ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"]
        case "anonsubgift":
            self.msgId = .anonSubGift(.init(
                months: parser.uint(for: "msg-param-months"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                giftMonths: parser.uint(for: "msg-param-gift-months"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions")
            ))
            occasionalSubDependentKeys = ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"]
        case "submysterygift":
            self.msgId = .subMysteryGift(.init(
                massGiftCount: parser.uint(for: "msg-param-mass-gift-count"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions"),
                giftTheme: parser.string(for: "msg-param-gift-theme")
            ))
            occasionalSubDependentKeys = ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions", "msg-param-gift-theme"]
        case "giftpaidupgrade":
            self.msgId = .giftPaidUpgrade(.init(
                promoGiftTotal: parser.uint(for: "msg-param-promo-gift-total"),
                promoName: parser.string(for: "msg-param-promo-name"),
                senderLogin: parser.string(for: "msg-param-sender-login"),
                senderName: parser.string(for: "msg-param-sender-name")
            ))
            occasionalSubDependentKeys = []
        case "rewardgift":
            self.msgId = .rewardGift
            occasionalSubDependentKeys = []
        case "anongiftpaidupgrade":
            self.msgId = .anonGiftPaidUpgrade(.init(
                promoGiftTotal: parser.uint(for: "msg-param-promo-gift-total"),
                promoName: parser.string(for: "msg-param-promo-name")
            ))
            occasionalSubDependentKeys = []
        case "raid":
            self.msgId = .raid(.init(
                displayName: parser.string(for: "msg-param-displayName"),
                login: parser.string(for: "msg-param-login"),
                viewerCount: parser.uint(for: "msg-param-viewerCount"),
                profileImageURL: parser.string(for: "msg-param-profileImageURL")
            ))
            occasionalSubDependentKeys = ["msg-param-profileImageURL"]
        case "unraid":
            self.msgId = .unraid
            occasionalSubDependentKeys = []
        case "ritual":
            self.msgId = .ritual(
                name: parser.string(for: "msg-param-ritual-name")
            )
            occasionalSubDependentKeys = []
        case "bitsbadgetier":
            self.msgId = .bitsBadgeTier(
                threshold: parser.string(for: "msg-param-threshold")
            )
            occasionalSubDependentKeys = []
        case "communitypayforward":
            self.msgId = .communityPayForward(.init(
                priorGifterAnonymous: parser.bool(for: "msg-param-prior-gifter-anonymous"),
                priorGifterDisplayName: parser.string(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: parser.string(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: parser.string(for: "msg-param-prior-gifter-user-name")
            ))
            occasionalSubDependentKeys = []
        case "standardpayforward":
            self.msgId = .standardPayForward(.init(
                priorGifterAnonymous: parser.bool(for: "msg-param-prior-gifter-anonymous"),
                priorGifterDisplayName: parser.string(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: parser.string(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: parser.string(for: "msg-param-prior-gifter-user-name"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name")
            ))
            occasionalSubDependentKeys = []
        default: return nil
        }
        
        self.badgeInfo = parser.array(for: "badge-info")
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.emotes = parser.array(for: "emotes")
        self.flags = parser.array(for: "flags")
        self.id = parser.string(for: "id")
        self.userLogin = parser.string(for: "login")
        self.roomId = parser.string(for: "room-id")
        self.systemMessage = parser.string(for: "system-msg")
        self.tmiSentTs = parser.uint(for: "tmi-sent-ts")
        self.userId = parser.string(for: "user-id")
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        let occasionalKeys = occasionalSubDependentKeys + ["flags"]
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys,
            excludedUnavailableKeys: occasionalKeys
        )
    }
}
