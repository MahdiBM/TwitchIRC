
/// Convenience protocol to add all the badge-related variables to messages.
public protocol MessageWithBadges {
    var badges: [String] { get }
}

public extension MessageWithBadges {
    var isMod: Bool {
        self.badges.contains(where: { $0.hasPrefix("moderator") })
    }
    var isSubscriber: Bool {
        self.badges.contains(where: { $0.hasPrefix("subscriber") })
    }
    var isBroadcaster: Bool {
        self.badges.contains(where: { $0.hasPrefix("broadcaster") })
    }
    var isVIP: Bool {
        self.badges.contains(where: { $0.hasPrefix("vip") })
    }
    var isTurbo: Bool {
        self.badges.contains(where: { $0.hasPrefix("turbo") })
    }
    var isStaff: Bool {
        self.badges.contains(where: { $0.hasPrefix("staff") })
    }
    var isGlobalMod: Bool {
        self.badges.contains(where: { $0.hasPrefix("global_mod") })
    }
}
