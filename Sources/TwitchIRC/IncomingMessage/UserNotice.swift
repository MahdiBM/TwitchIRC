
/// A Twitch `USERNOTICE` message.
public struct UserNotice: MessageWithBadges {
    
    public enum MessageID {
        
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
            
            internal init(
                cumulativeMonths: UInt,
                shouldShareStreak: Bool,
                streakMonths: UInt,
                subPlan: UserNotice.MessageID.SubPlan?,
                subPlanName: String,
                months: UInt,
                multimonthDuration: UInt,
                multimonthTenure: Bool,
                wasGifted: Bool,
                goalContributionType: String,
                goalCurrentContributions: String,
                goalDescription: String,
                goalTargetContributions: String,
                goalUserContributions: String
            ) {
                self.cumulativeMonths = cumulativeMonths
                self.shouldShareStreak = shouldShareStreak
                self.streakMonths = streakMonths
                self.subPlan = subPlan
                self.subPlanName = subPlanName
                self.months = months
                self.multimonthDuration = multimonthDuration
                self.multimonthTenure = multimonthTenure
                self.wasGifted = wasGifted
                self.goalContributionType = goalContributionType
                self.goalCurrentContributions = goalCurrentContributions
                self.goalDescription = goalDescription
                self.goalTargetContributions = goalTargetContributions
                self.goalUserContributions = goalUserContributions
            }
            
            public init() {
                self.init(
                    cumulativeMonths: UInt(),
                    shouldShareStreak: Bool(),
                    streakMonths: UInt(),
                    subPlan: nil,
                    subPlanName: String(),
                    months: UInt(),
                    multimonthDuration: UInt(),
                    multimonthTenure: Bool(),
                    wasGifted: Bool(),
                    goalContributionType: String(),
                    goalCurrentContributions: String(),
                    goalDescription: String(),
                    goalTargetContributions: String(),
                    goalUserContributions: String()
                )
            }
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
            
            internal init(
                cumulativeMonths: UInt,
                shouldShareStreak: Bool,
                streakMonths: UInt,
                subPlan: UserNotice.MessageID.SubPlan?,
                subPlanName: String,
                anonGift: Bool,
                months: UInt,
                multimonthDuration: UInt,
                multimonthTenure: Bool,
                wasGifted: Bool,
                giftMonthBeingRedeemed: UInt,
                giftMonths: UInt,
                gifterId: String,
                gifterLogin: String,
                gifterName: String
            ) {
                self.cumulativeMonths = cumulativeMonths
                self.shouldShareStreak = shouldShareStreak
                self.streakMonths = streakMonths
                self.subPlan = subPlan
                self.subPlanName = subPlanName
                self.anonGift = anonGift
                self.months = months
                self.multimonthDuration = multimonthDuration
                self.multimonthTenure = multimonthTenure
                self.wasGifted = wasGifted
                self.giftMonthBeingRedeemed = giftMonthBeingRedeemed
                self.giftMonths = giftMonths
                self.gifterId = gifterId
                self.gifterLogin = gifterLogin
                self.gifterName = gifterName
            }
            
            public init() {
                self.init(
                    cumulativeMonths: UInt(),
                    shouldShareStreak: Bool(),
                    streakMonths: UInt(),
                    subPlan: nil,
                    subPlanName: String(),
                    anonGift: Bool(),
                    months: UInt(),
                    multimonthDuration: UInt(),
                    multimonthTenure: Bool(),
                    wasGifted: Bool(),
                    giftMonthBeingRedeemed: UInt(),
                    giftMonths: UInt(),
                    gifterId: String(),
                    gifterLogin: String(),
                    gifterName: String()
                )
            }
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
            public var funString: String
            public var giftTheme: String
            public var goalContributionType: String
            public var goalCurrentContributions: String
            public var goalDescription: String
            public var goalTargetContributions: String
            public var goalUserContributions: String
            public var communityGiftId: String

            internal init(
                months: UInt,
                recipientDisplayName: String,
                recipientId: String,
                recipientUserName: String,
                subPlan: UserNotice.MessageID.SubPlan?,
                subPlanName: String,
                giftMonths: UInt,
                originId: String,
                senderCount: UInt,
                funString: String,
                giftTheme: String,
                goalContributionType: String,
                goalCurrentContributions: String,
                goalDescription: String,
                goalTargetContributions: String,
                goalUserContributions: String,
                communityGiftId: String
            ) {
                self.months = months
                self.recipientDisplayName = recipientDisplayName
                self.recipientId = recipientId
                self.recipientUserName = recipientUserName
                self.subPlan = subPlan
                self.subPlanName = subPlanName
                self.giftMonths = giftMonths
                self.originId = originId
                self.senderCount = senderCount
                self.funString = funString
                self.giftTheme = giftTheme
                self.goalContributionType = goalContributionType
                self.goalCurrentContributions = goalCurrentContributions
                self.goalDescription = goalDescription
                self.goalTargetContributions = goalTargetContributions
                self.goalUserContributions = goalUserContributions
                self.communityGiftId = communityGiftId
            }
            
            public init() {
                self.init(
                    months: UInt(),
                    recipientDisplayName: String(),
                    recipientId: String(),
                    recipientUserName: String(),
                    subPlan: nil,
                    subPlanName: String(),
                    giftMonths: UInt(),
                    originId: String(),
                    senderCount: UInt(),
                    funString: String(),
                    giftTheme: String(),
                    goalContributionType: String(),
                    goalCurrentContributions: String(),
                    goalDescription: String(),
                    goalTargetContributions: String(),
                    goalUserContributions: String(),
                    communityGiftId: String()
                )
            }
        }
        
        public struct PrimePaidUpgradeInfo {
            public var subPlan: SubPlan?
            
            internal init(subPlan: SubPlan?) {
                self.subPlan = subPlan
            }
            
            public init() {
                self.subPlan = nil
            }
        }
        
        public struct GiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
            public var senderLogin: String
            public var senderName: String
            
            internal init(
                promoGiftTotal: UInt,
                promoName: String,
                senderLogin: String,
                senderName: String
            ) {
                self.promoGiftTotal = promoGiftTotal
                self.promoName = promoName
                self.senderLogin = senderLogin
                self.senderName = senderName
            }
            
            public init() {
                self.init(
                    promoGiftTotal: UInt(),
                    promoName: String(),
                    senderLogin: String(),
                    senderName: String()
                )
            }
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
            public var communityGiftId: String

            internal init(
                massGiftCount: UInt,
                originId: String,
                senderCount: UInt,
                subPlan: SubPlan?,
                goalContributionType: String,
                goalCurrentContributions: String,
                goalDescription: String,
                goalTargetContributions: String,
                goalUserContributions: String,
                giftTheme: String,
                communityGiftId: String
            ) {
                self.massGiftCount = massGiftCount
                self.originId = originId
                self.senderCount = senderCount
                self.subPlan = subPlan
                self.goalContributionType = goalContributionType
                self.goalCurrentContributions = goalCurrentContributions
                self.goalDescription = goalDescription
                self.goalTargetContributions = goalTargetContributions
                self.goalUserContributions = goalUserContributions
                self.giftTheme = giftTheme
                self.communityGiftId = communityGiftId
            }
            
            public init() {
                self.init(
                    massGiftCount: UInt(),
                    originId: String(),
                    senderCount: UInt(),
                    subPlan: nil,
                    goalContributionType: String(),
                    goalCurrentContributions: String(),
                    goalDescription: String(),
                    goalTargetContributions: String(),
                    goalUserContributions: String(),
                    giftTheme: String(),
                    communityGiftId: String()
                )
            }
        }
        
        public struct AnonGiftPaidUpgradeInfo {
            public var promoGiftTotal: UInt
            public var promoName: String
            
            internal init(
                promoGiftTotal: UInt,
                promoName: String
            ) {
                self.promoGiftTotal = promoGiftTotal
                self.promoName = promoName
            }
            
            public init() {
                self.init(
                    promoGiftTotal: UInt(),
                    promoName: String()
                )
            }
        }
        
        public struct RaidInfo {
            public var displayName: String
            public var login: String
            public var viewerCount: UInt
            public var profileImageURL: String
            
            internal init(
                displayName: String,
                login: String,
                viewerCount: UInt,
                profileImageURL: String
            ) {
                self.displayName = displayName
                self.login = login
                self.viewerCount = viewerCount
                self.profileImageURL = profileImageURL
            }
            
            public init() {
                self.init(
                    displayName: String(),
                    login: String(),
                    viewerCount: UInt(),
                    profileImageURL: String()
                )
            }
        }
        
        public struct CommunityPayForwardInfo {
            public var priorGifterAnonymous: Bool
            public var priorGifterDisplayName: String
            public var priorGifterId: String
            public var priorGifterUserName: String
            
            internal init(
                priorGifterAnonymous: Bool,
                priorGifterDisplayName: String,
                priorGifterId: String,
                priorGifterUserName: String
            ) {
                self.priorGifterAnonymous = priorGifterAnonymous
                self.priorGifterDisplayName = priorGifterDisplayName
                self.priorGifterId = priorGifterId
                self.priorGifterUserName = priorGifterUserName
            }
            
            public init() {
                self.init(
                    priorGifterAnonymous: Bool(),
                    priorGifterDisplayName: String(),
                    priorGifterId: String(),
                    priorGifterUserName: String()
                )
            }
        }
        
        public struct StandardPayForwardInfo {
            public var priorGifterAnonymous: Bool
            public var priorGifterDisplayName: String
            public var priorGifterId: String
            public var priorGifterUserName: String
            public var recipientDisplayName: String
            public var recipientId: String
            public var recipientUserName: String
            
            internal init(
                priorGifterAnonymous: Bool,
                priorGifterDisplayName: String,
                priorGifterId: String,
                priorGifterUserName: String,
                recipientDisplayName: String,
                recipientId: String,
                recipientUserName: String
            ) {
                self.priorGifterAnonymous = priorGifterAnonymous
                self.priorGifterDisplayName = priorGifterDisplayName
                self.priorGifterId = priorGifterId
                self.priorGifterUserName = priorGifterUserName
                self.recipientDisplayName = recipientDisplayName
                self.recipientId = recipientId
                self.recipientUserName = recipientUserName
            }
            
            public init() {
                self.init(
                    priorGifterAnonymous: Bool(),
                    priorGifterDisplayName: String(),
                    priorGifterId: String(),
                    priorGifterUserName: String(),
                    recipientDisplayName: String(),
                    recipientId: String(),
                    recipientUserName: String()
                )
            }
        }
        
        public struct MidnightSquidInfo {
            public var amount: UInt
            public var currency: String
            public var emoteId: String
            public var exponent: UInt
            public var isHighlighted: Bool
            public var pillType: String
            
            internal init(
                amount: UInt,
                currency: String,
                emoteId: String,
                exponent: UInt,
                isHighlighted: Bool,
                pillType: String
            ) {
                self.amount = amount
                self.currency = currency
                self.emoteId = emoteId
                self.exponent = exponent
                self.isHighlighted = isHighlighted
                self.pillType = pillType
            }
            
            public init() {
                self.init(
                    amount: UInt(),
                    currency: String(),
                    emoteId: String(),
                    exponent: UInt(),
                    isHighlighted: Bool(),
                    pillType: String()
                )
            }
        }
        
        public struct CharityDonationInfo {
            public var charityName: String
            public var amount: UInt
            public var currency: String
            public var exponent: UInt
            
            internal init(
                charityName: String,
                amount: UInt,
                currency: String,
                exponent: UInt
            ) {
                self.charityName = charityName
                self.amount = amount
                self.currency = currency
                self.exponent = exponent
            }
            
            public init() {
                self.init(
                    charityName: String(),
                    amount: UInt(),
                    currency: String(),
                    exponent: UInt()
                )
            }
        }
        
        public struct ViewerMilestoneInfo {
            public var category: String
            public var id: String
            public var value: UInt
            public var copoReward: UInt

            internal init(
                category: String,
                id: String,
                value: UInt,
                copoReward: UInt
            ) {
                self.category = category
                self.id = id
                self.value = value
                self.copoReward = copoReward
            }
            
            public init() {
                self.init(
                    category: String(),
                    id: String(),
                    value: UInt(),
                    copoReward: UInt()
                )
            }
        }
        
        case sub(SubInfo)
        case resub(ReSubInfo)
        case subGift(SubGiftInfo)
        case anonSubGift(SubGiftInfo)
        case subMysteryGift(SubMysteryGiftInfo)
        case primePaidUpgrade(PrimePaidUpgradeInfo)
        case giftPaidUpgrade(GiftPaidUpgradeInfo)
        case rewardGift
        case anonGiftPaidUpgrade(AnonGiftPaidUpgradeInfo)
        case raid(RaidInfo)
        case unraid
        case ritual(name: String)
        case bitsBadgeTier(threshold: String)
        case communityPayForward(CommunityPayForwardInfo)
        case standardPayForward(StandardPayForwardInfo)
        case announcement(color: String?)
        case midnightSquid(MidnightSquidInfo)
        case charityDonation(CharityDonationInfo)
        case viewerMilestone(ViewerMilestoneInfo)
    }
    
    /// Channel's name with no uppercased/Han characters.
    public var channel = String()
    /// Possible message sent by user.
    public var message = String()
    /// User's badge info.
    public var badgeInfo = [String]()
    /// User's badges.
    public var badges = [String]()
    /// User's in-chat name color.
    public var color = String()
    /// User's display name with uppercased/Han characters.
    public var displayName = String()
    /// User is VIP or not.
    public var vip = Bool()
    /// User's sent emotes.
    public var emotes = String()
    /// Flags of this notice.
    public var flags = [String]()
    /// Message's id.
    public var id = String()
    /// User's name with no uppercased/Han characters.
    public var userLogin = String()
    /// More-precise info about this user notice.
    public var messageId: MessageID!
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
    
    public func parseEmotes() -> [Emote] {
        Emote.parse(from: emotes, and: message)
    }
    
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
            /// and other normal methods like a simple `.dropFirst()` fail in rare cases.
            /// Remove `.unicodeScalars` of `PrivateMessage`'s `message` and run tests to find out.
            self.message = String(message.unicodeScalars.dropFirst())
        } else {
            self.channel = String(contentRhs.dropFirst())
        }
        
        var parser = ParametersParser(String(contentLhs.dropLast(2).dropFirst()))
        
        let occasionalSubDependentKeyGroups: [[String]]
        
        switch parser.optionalString(for: "msg-id") {
        case "sub":
            self.messageId = .sub(.init(
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
            occasionalSubDependentKeyGroups = [["msg-param-streak-months"], ["msg-param-goal-description"], ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"]]
        case "resub":
            self.messageId = .resub(.init(
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
            occasionalSubDependentKeyGroups = [["msg-param-streak-months"], ["msg-param-multimonth-duration", "msg-param-multimonth-tenure"], ["msg-param-anon-gift", "msg-param-gift-month-being-redeemed", "msg-param-gift-months", "msg-param-gifter-id", "msg-param-gifter-login", "msg-param-gifter-name"], ["msg-param-months", "msg-param-multimonth-duration", "msg-param-multimonth-tenure", "msg-param-was-gifted"]]
        case "subgift":
            self.messageId = .subGift(.init(
                months: parser.uint(for: "msg-param-months"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                giftMonths: parser.uint(for: "msg-param-gift-months"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                funString: parser.string(for: "msg-param-fun-string"),
                giftTheme: parser.string(for: "msg-param-gift-theme"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions"),
                communityGiftId: parser.string(for: "msg-param-community-gift-id")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-sender-count"], ["msg-param-goal-description"], ["msg-param-gift-theme"], ["msg-param-fun-string"], ["msg-param-gift-months", "msg-param-origin-id"], ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"], ["msg-param-community-gift-id"]]
        case "anonsubgift":
            self.messageId = .anonSubGift(.init(
                months: parser.uint(for: "msg-param-months"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                subPlanName: parser.string(for: "msg-param-sub-plan-name"),
                giftMonths: parser.uint(for: "msg-param-gift-months"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                funString: parser.string(for: "msg-param-fun-string"),
                giftTheme: parser.string(for: "msg-param-gift-theme"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions"),
                communityGiftId: parser.string(for: "msg-param-community-gift-id")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-sender-count"], ["msg-param-fun-string"], ["msg-param-gift-theme"], ["msg-param-gift-months", "msg-param-origin-id"], ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"], ["msg-param-community-gift-id"]]
        case "submysterygift":
            self.messageId = .subMysteryGift(.init(
                massGiftCount: parser.uint(for: "msg-param-mass-gift-count"),
                originId: parser.string(for: "msg-param-origin-id"),
                senderCount: parser.uint(for: "msg-param-sender-count"),
                subPlan: parser.representable(for: "msg-param-sub-plan"),
                goalContributionType: parser.string(for: "msg-param-goal-contribution-type"),
                goalCurrentContributions: parser.string(for: "msg-param-goal-current-contributions"),
                goalDescription: parser.string(for: "msg-param-goal-description"),
                goalTargetContributions: parser.string(for: "msg-param-goal-target-contributions"),
                goalUserContributions: parser.string(for: "msg-param-goal-user-contributions"),
                giftTheme: parser.string(for: "msg-param-gift-theme"),
                communityGiftId: parser.string(for: "msg-param-community-gift-id")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-goal-description"], ["msg-param-sender-count"], ["msg-param-goal-contribution-type", "msg-param-goal-current-contributions", "msg-param-goal-description", "msg-param-goal-target-contributions", "msg-param-goal-user-contributions"], ["msg-param-gift-theme"]]
        case "primepaidupgrade":
            self.messageId = .primePaidUpgrade(.init(
                subPlan: parser.representable(for: "msg-param-sub-plan")
            ))
            occasionalSubDependentKeyGroups = []
        case "giftpaidupgrade":
            self.messageId = .giftPaidUpgrade(.init(
                promoGiftTotal: parser.uint(for: "msg-param-promo-gift-total"),
                promoName: parser.string(for: "msg-param-promo-name"),
                senderLogin: parser.string(for: "msg-param-sender-login"),
                senderName: parser.string(for: "msg-param-sender-name")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-promo-gift-total", "msg-param-promo-name"]]
        case "rewardgift":
            self.messageId = .rewardGift
            occasionalSubDependentKeyGroups = []
        case "anongiftpaidupgrade":
            self.messageId = .anonGiftPaidUpgrade(.init(
                promoGiftTotal: parser.uint(for: "msg-param-promo-gift-total"),
                promoName: parser.string(for: "msg-param-promo-name")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-promo-gift-total"], ["msg-param-promo-name"]]
        case "raid":
            self.messageId = .raid(.init(
                displayName: parser.string(for: "msg-param-displayName"),
                login: parser.string(for: "msg-param-login"),
                viewerCount: parser.uint(for: "msg-param-viewerCount"),
                profileImageURL: parser.string(for: "msg-param-profileImageURL")
            ))
            occasionalSubDependentKeyGroups = [["msg-param-profileImageURL"]]
        case "unraid":
            self.messageId = .unraid
            occasionalSubDependentKeyGroups = []
        case "ritual":
            self.messageId = .ritual(
                name: parser.string(for: "msg-param-ritual-name")
            )
            occasionalSubDependentKeyGroups = []
        case "bitsbadgetier":
            self.messageId = .bitsBadgeTier(
                threshold: parser.string(for: "msg-param-threshold")
            )
            occasionalSubDependentKeyGroups = []
        case "communitypayforward":
            self.messageId = .communityPayForward(.init(
                priorGifterAnonymous: parser.bool(for: "msg-param-prior-gifter-anonymous"),
                priorGifterDisplayName: parser.string(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: parser.string(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: parser.string(for: "msg-param-prior-gifter-user-name")
            ))
            occasionalSubDependentKeyGroups = []
        case "standardpayforward":
            self.messageId = .standardPayForward(.init(
                priorGifterAnonymous: parser.bool(for: "msg-param-prior-gifter-anonymous"),
                priorGifterDisplayName: parser.string(for: "msg-param-prior-gifter-display-name"),
                priorGifterId: parser.string(for: "msg-param-prior-gifter-id"),
                priorGifterUserName: parser.string(for: "msg-param-prior-gifter-user-name"),
                recipientDisplayName: parser.string(for: "msg-param-recipient-display-name"),
                recipientId: parser.string(for: "msg-param-recipient-id"),
                recipientUserName: parser.string(for: "msg-param-recipient-user-name")
            ))
            occasionalSubDependentKeyGroups = []
        case "announcement":
            self.messageId = .announcement(color: parser.optionalString(for: "msg-param-color"))
            occasionalSubDependentKeyGroups = [["msg-param-color"]]
        case "midnightsquid":
            self.messageId = .midnightSquid(.init(
                amount: parser.uint(for: "msg-param-amount"),
                currency: parser.string(for: "msg-param-currency"),
                emoteId: parser.string(for: "msg-param-emote-id"),
                exponent: parser.uint(for: "msg-param-exponent"),
                isHighlighted: parser.bool(for: "msg-param-is-highlighted"),
                pillType: parser.string(for: "msg-param-pill-type")
            ))
            occasionalSubDependentKeyGroups = []
        case "charitydonation":
            self.messageId = .charityDonation(.init(
                charityName: parser.string(for: "msg-param-charity-name"),
                amount: parser.uint(for: "msg-param-donation-amount"),
                currency: parser.string(for: "msg-param-donation-currency"),
                exponent: parser.uint(for: "msg-param-exponent")
            ))
            occasionalSubDependentKeyGroups = []
        case "viewermilestone":
            self.messageId = .viewerMilestone(.init(
                category: parser.string(for: "msg-param-category"),
                id: parser.string(for: "msg-param-id"),
                value: parser.uint(for: "msg-param-value"),
                copoReward: parser.uint(for: "msg-param-copoReward")
            ))
            occasionalSubDependentKeyGroups = []
        default: return nil
        }
        
        self.badgeInfo = parser.array(for: "badge-info")
        self.badges = parser.array(for: "badges")
        self.color = parser.string(for: "color")
        self.displayName = parser.string(for: "display-name")
        self.vip = parser.bool(for: "vip")
        self.emotes = parser.string(for: "emotes")
        self.flags = parser.array(for: "flags")
        self.id = parser.string(for: "id")
        self.userLogin = parser.string(for: "login")
        self.roomId = parser.string(for: "room-id")
        self.systemMessage = parser.string(for: "system-msg")
        self.tmiSentTs = parser.uint(for: "tmi-sent-ts")
        self.userId = parser.string(for: "user-id")
        
        let deprecatedKeys = ["turbo", "mod", "subscriber", "user-type"]
        let occasionalKeys: [[String]] = occasionalSubDependentKeyGroups + [["flags"]]
        self.parsingLeftOvers = parser.getLeftOvers(
            excludedUnusedKeys: deprecatedKeys,
            groupsOfExcludedUnavailableKeys: occasionalKeys
        )
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension UserNotice: Sendable { }
extension UserNotice.MessageID: Sendable { }
extension UserNotice.MessageID.SubPlan: Sendable { }
extension UserNotice.MessageID.SubInfo: Sendable { }
extension UserNotice.MessageID.ReSubInfo: Sendable { }
extension UserNotice.MessageID.SubGiftInfo: Sendable { }
extension UserNotice.MessageID.PrimePaidUpgradeInfo: Sendable { }
extension UserNotice.MessageID.GiftPaidUpgradeInfo: Sendable { }
extension UserNotice.MessageID.SubMysteryGiftInfo: Sendable { }
extension UserNotice.MessageID.AnonGiftPaidUpgradeInfo: Sendable { }
extension UserNotice.MessageID.RaidInfo: Sendable { }
extension UserNotice.MessageID.CommunityPayForwardInfo: Sendable { }
extension UserNotice.MessageID.StandardPayForwardInfo: Sendable { }
extension UserNotice.MessageID.MidnightSquidInfo: Sendable { }
extension UserNotice.MessageID.CharityDonationInfo: Sendable { }
extension UserNotice.MessageID.ViewerMilestoneInfo: Sendable { }
#endif
