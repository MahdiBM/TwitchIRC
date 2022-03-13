
/// A Twitch `NOTICE` message.
public struct Notice {
    
    public enum MessageID: String, CaseIterable {
        /// <user> is already banned in this channel.
        case alreadyBanned = "alreadybanned"
        /// This room is not in emote-only mode.
        case alreadyEmoteOnlyOff = "alreadyemoteonlyoff"
        /// This room is already in emote-only mode.
        case alreadyEmoteOnlyOn = "alreadyemoteonlyon"
        /// This room is not in r9k mode.
        case alreadyR9kOff = "alreadyr9koff"
        /// This room is already in r9k mode.
        case alreadyR9kOn = "alreadyr9kon"
        /// This room is not in subscribers-only mode.
        case alreadySubsOff = "alreadysubsoff"
        /// This room is already in subscribers-only mode.
        case alreadySubsOn = "alreadysubson"
        /// You cannot ban admin <user>. Please email support@twitch.tv if an admin is being abusive.
        case badBanAdmin = "badbanadmin"
        /// You cannot ban anonymous users.
        case badBanAnon = "badbananon"
        /// You cannot ban the broadcaster.
        case badBanBroadcaster = "badbanbroadcaster"
        /// You cannot ban global moderator <user>. Please email support@twitch.tv if a global moderator is being abusive.
        case badBanGlobalMod = "badbanglobalmod"
        /// You cannot ban moderator <user> unless you are the owner of this channel.
        case badBanMod = "badbanmod"
        /// You cannot ban yourself.
        case badBanSelf = "badbanself"
        /// You cannot ban a staff <user>. Please email support@twitch.tv if a staff member is being abusive.
        case badBanStaff = "badbanstaff"
        /// Failed to start commercial.
        case badCommercialError = "badcommercialerror"
        /// You cannot delete the broadcaster's messages.
        case badDeleteMessageBroadcaster = "baddeletemessagebroadcaster"
        /// Failed to delete message.
        case badDeleteMessageError = "baddeletemessageerror"
        /// You cannot delete messages from another moderator <user>.
        case badDeleteMessageMod = "baddeletemessagemod"
        /// There was a problem hosting <channel>. Please try again in a minute.
        case badHostError = "badhosterror"
        /// This channel is already hosting <channel>.
        case badHostHosting = "badhosthosting"
        /// Host target cannot be changed more than <number> times every half hour.
        case badHostRateExceeded = "badhostrateexceeded"
        /// This channel is unable to be hosted.
        case badHostRejected = "badhostrejected"
        /// A channel cannot host itself.
        case badHostSelf = "badhostself"
        /// Sorry, /marker is not available through this client.
        case badMarkerClient = "badmarkerclient"
        /// <user> is banned in this channel. You must unban this user before granting mod status.
        case badModBanned = "badmodbanned"
        /// <user> is already a moderator of this channel.
        case badModMod = "badmodmod"
        /// You cannot set slow delay to more than <number> seconds.
        case badSlowDuration = "badslowduration"
        /// You cannot timeout admin <user>. Please email support@twitch.tv if an admin is being abusive.
        case badTimeoutAdmin = "badtimeoutadmin"
        /// You cannot timeout anonymous users.
        case badTimeoutAnon = "badtimeoutanon"
        /// You cannot timeout the broadcaster.
        case badTimeoutBroadcaster = "badtimeoutbroadcaster"
        /// You cannot time a user out for more than <seconds>.
        case badTimeoutDuration = "badtimeoutduration"
        /// You cannot timeout global moderator <user>. Please email support@twitch.tv if a global moderator is being abusive.
        case badTimeoutGlobalMod = "badtimeoutglobalmod"
        /// You cannot timeout moderator <user> unless you are the owner of this channel.
        case badTimeoutMod = "badtimeoutmod"
        /// You cannot timeout yourself.
        case badTimeoutSelf = "badtimeoutself"
        /// You cannot timeout staff <user>. Please email support@twitch.tv if a staff member is being abusive.
        case badTimeoutStaff = "badtimeoutstaff"
        /// <user> is not banned from this channel.
        case badUnbanNoBan = "badunbannoban"
        /// There was a problem exiting host mode. Please try again in a minute.
        case badUnhostError = "badunhosterror"
        /// <user> is not a moderator of this channel.
        case badUnmodMod = "badunmodmod"
        /// <user> is not a VIP of this channel.
        case badUnvipGranteeNotVip = "badunvipgranteenotvip"
        /// Unable to add VIP. Visit the Achievements page on your dashboard to learn how to unlock this feature.
        case badVipAchievementIncomplete = "badvipachievementincomplete"
        /// <user> is already a VIP of this channel.
        case badVipGranteeAlreadyVip = "badvipgranteealreadyvip"
        /// <user> is banned in this channel. You must unban this user before granting VIP status.
        case badVipGranteeBanned = "badvipgranteebanned"
        /// Unable to add VIP. Visit the Achievements page on your dashboard to learn how to unlock additional VIP slots.
        case badVipMaxVipsReached = "badvipmaxvipsreached"
        /// <user> is now banned from this channel.
        case banSuccess = "bansuccess"
        /// Commands available to you in this room (use /help <command> for details): <list of commands>
        case cmdsAvailable = "cmdsavailable"
        /// Your color has been changed.
        case colorChanged = "colorchanged"
        /// Initiating <number> second commercial break. Keep in mind that your stream is still live and not everyone will get a commercial.
        case commercialSuccess = "commercialsuccess"
        /// The message from <user> is now deleted.
        case deleteMessageSuccess = "deletemessagesuccess"
        /// This room is no longer in emote-only mode.
        case emoteOnlyOff = "emoteonlyoff"
        /// This room is now in emote-only mode.
        case emoteOnlyOn = "emoteonlyon"
        /// This room is no longer in followers-only mode. Note: The followers tags are broadcast to a channel when a moderator makes changes.
        case followersOff = "followersoff"
        /// This room is now in <duration> followers-only mode. Examples: “This room is now in 2 week followers-only mode.” or “This room is now in 1 minute followers-only mode.”
        case followersOn = "followerson"
        /// This room is now in followers-only mode.
        case followersOnZero = "followersonzero"
        /// Exited host mode.
        case hostOff = "hostoff"
        /// Now hosting <channel>.
        case hostOn = "hoston"
        /// <user> is now hosting you.
        case hostSuccess = "hostsuccess"
        /// <user> is now hosting you for up to <number> viewers.
        case hostSuccessViewers = "hostsuccessviewers"
        /// <channel> has gone offline. Exiting host mode.
        case hostTargetWentOffline = "hosttargetwentoffline"
        /// <number> host commands remaining this half hour.
        case hostsRemaining = "hostsremaining"
        /// Invalid username: <user>
        case invalidUser = "invaliduser"
        /// You have added <user> as a moderator of this channel.
        case modSuccess = "modsuccess"
        /// You are permanently banned from talking in <channel>.
        case msgBanned = "msgbanned"
        /// Your message was not sent because it contained too many characters that could not be processed. If you believe this is an error, rephrase and try again.
        case msgBadCharacters = "msgbadcharacters"
        /// Your message was not sent because your email address is banned from this channel.
        case msgBannedEmailAlias = "msgbannedemailalias"
        /// Your message was not sent because your account is not in good standing in this channel.
        case msgChannelBlocked = "msgchannelblocked"
        /// This channel has been suspended.
        case msgChannelSuspended = "msgchannelsuspended"
        /// Your message was not sent because it is identical to the previous one you sent, less than 30 seconds ago.
        case msgDuplicate = "msgduplicate"
        /// This room is in emote only mode. You can find your currently available emoticons using the smiley in the chat text area.
        case msgEmoteOnly = "msgemoteonly"
        /// You must use Facebook Connect to send messages to this channel. You can see Facebook Connect in your Twitch settings under the connections tab.
        case msgFacebook = "msgfacebook"
        /// This room is in <duration> followers-only mode. Follow <channel> to join the community!Note: These msg_followers tags are kickbacks to a user who does not meet the criteria; that is, does not follow or has not followed long enough.
        case msgFollowersOnly = "msgfollowersonly"
        /// This room is in <duration1> followers-only mode. You have been following for <duration2>. Continue following to chat!
        case msgFollowersOnlyFollowed = "msgfollowersonlyfollowed"
        /// This room is in followers-only mode. Follow <channel> to join the community!
        case msgFollowersOnlyZero = "msgfollowersonlyzero"
        /// This room is in r9k mode and the message you attempted to send is not unique.
        case msgR9k = "msgr9k"
        /// Your message was not sent because you are sending messages too quickly.
        case msgRateLimit = "msgratelimit"
        /// Hey! Your message is being checked by mods and has not been sent.
        case msgRejected = "msgrejected"
        /// Your message wasn't posted due to conflicts with the channel's moderation settings.
        case msgRejectedMandatory = "msgrejectedmandatory"
        /// A verified phone number is required to chat in this channel. Please visit https://www.twitch.tv/settings/security to verify your phone number.
        case msgRequiresVerifiedPhoneNumber = "msgrequiresverifiedphonenumber"
        /// The room was not found.
        case msgRoomNotFound = "msgroomnotfound"
        /// This room is in slow mode and you are sending messages too quickly. You will be able to talk again in <number> seconds.
        case msgSlowMode = "msgslowmode"
        /// This room is in subscribers only mode. To talk, purchase a channel subscription at https://www.twitch.tv/products/<broadcaster login name>/ticket?ref=subscriber_only_mode_chat.
        case msgSubsOnly = "msgsubsonly"
        /// Your account has been suspended.
        case msgSuspended = "msgsuspended"
        /// You are banned from talking in <channel> for <number> more seconds.
        case msgTimedOut = "msgtimedout"
        /// This room requires a verified email address to chat. Please verify your email at https://www.twitch.tv/settings/profile.
        case msgVerifiedEmail = "msgverifiedemail"
        /// No help available.
        case noHelp = "nohelp"
        /// There are no moderators of this channel.
        case noMods = "nomods"
        /// No channel is currently being hosted.
        case notHosting = "nothosting"
        /// You don’t have permission to perform that action.
        case noPermission = "nopermission"
        /// This channel does not have any VIPs.
        case noVips = "novips"
        /// This room is no longer in r9k mode.
        case r9kOff = "r9koff"
        /// This room is now in r9k mode.
        case r9kOn = "r9kon"
        /// You already have a raid in progress.
        case raidErrorAlreadyRaiding = "raiderroralreadyraiding"
        /// You cannot raid this channel.
        case raidErrorForbidden = "raiderrorforbidden"
        /// A channel cannot raid itself.
        case raidErrorSelf = "raiderrorself"
        /// Sorry, you have more viewers than the maximum currently supported by raids right now.
        case raidErrorTooManyViewers = "raiderrortoomanyviewers"
        /// There was a problem raiding <channel>. Please try again in a minute.
        case raidErrorUnexpected = "raiderrorunexpected"
        /// This channel is intended for mature audiences.
        case raidNoticeMature = "raidnoticemature"
        /// This channel has follower or subscriber only chat.
        case raidNoticeRestrictedChat = "raidnoticerestrictedchat"
        /// The moderators of this channel are: <list of users>
        case roomMods = "roommods"
        /// This room is no longer in slow mode.
        case slowOff = "slowoff"
        /// This room is now in slow mode. You may send messages every <number> seconds.
        case slowOn = "slowon"
        /// This room is no longer in subscribers-only mode.
        case subsOff = "subsoff"
        /// This room is now in subscribers-only mode.
        case subsOn = "subson"
        /// <user> is not timed out from this channel.
        case timeoutNoTimeout = "timeoutnotimeout"
        /// <user> has been timed out for <duration> seconds.
        case timeoutSuccess = "timeoutsuccess"
        /// The community has closed channel <channel> due to Terms of Service violations.
        case tosBan = "tosban"
        /// Only turbo users can specify an arbitrary hex color. Use one of the following instead: <list of colors>.
        case turboOnlyColor = "turboonlycolor"
        /// <user> is no longer banned from this channel.
        case unbanSuccess = "unbansuccess"
        /// You have removed <user> as a moderator of this channel.
        case unmodSuccess = "unmodsuccess"
        /// You do not have an active raid.
        case unraidErrorNoActiveRaid = "unraiderrornoactiveraid"
        /// There was a problem stopping the raid. Please try again in a minute.
        case unraidErrorUnexpected = "unraiderrorunexpected"
        /// The raid has been cancelled.
        case unraidSuccess = "unraidsuccess"
        /// Unrecognized command: <command>
        case unrecognizedCmd = "unrecognizedcmd"
        /// The command <command> cannot be used in a chatroom.
        case unsupportedChatroomsCmd = "unsupportedchatroomscmd"
        /// <user> is permanently banned. Use "/unban" to remove a ban.
        case untimeoutBanned = "untimeoutbanned"
        /// <user> is no longer timed out in this channel.
        case untimeoutSuccess = "untimeoutsuccess"
        /// You have removed <user> as a VIP of this channel.
        case unvipSuccess = "unvipsuccess"
        /// Usage: “/ban <username> [reason]” Permanently prevent a user from chatting. Reason is optional and will be shown to the target and other moderators. Use “/unban” to remove a ban.
        case usageBan = "usageban"
        /// Usage: “/clear” Clear chat history for all users in this room.
        case usageClear = "usageclear"
        /// Usage: “/color <color>” Change your username color. Color must be in hex (#000000) or one of the following: Blue, BlueViolet, CadetBlue, Chocolate, Coral, DodgerBlue, Firebrick, GoldenRod, Green, HotPink, OrangeRed, Red, SeaGreen, SpringGreen, YellowGreen.
        case usageColor = "usagecolor"
        /// Usage: “/commercial [length]” Triggers a commercial. Length (optional) must be a positive number of seconds.
        case usageCommercial = "usagecommercial"
        /// Usage: “/disconnect” Reconnects to chat.
        case usageDisconnect = "usagedisconnect"
        /// Usage: “/emoteonlyoff” Disables emote-only mode.
        case usageEmoteOnlyOff = "usageemoteonlyoff"
        /// Usage: “/emoteonly” Enables emote-only mode (only emoticons may be used in chat). Use /emoteonlyoff to disable.
        case usageEmoteOnlyOn = "usageemoteonlyon"
        /// Usage: “/followersoff” Disables followers-only mode.
        case usageFollowersOff = "usagefollowersoff"
        /// Usage: “/followers” Enables followers-only mode (only users who have followed for “duration” may chat). Examples: “30m”, “1 week”, “5 days 12 hours”. Must be less than 3 months.
        case usageFollowersOn = "usagefollowerson"
        /// Usage: “/help” Lists the commands available to you in this room.
        case usageHelp = "usagehelp"
        /// Usage: “/host <channel>” Host another channel. Use “/unhost” to unset host mode.
        case usageHost = "usagehost"
        /// Usage: “/marker <optional comment>” Adds a stream marker (with an optional comment, max 140 characters) at the current timestamp. You can use markers in the Highlighter for easier editing.
        case usageMarker = "usagemarker"
        /// Usage: “/me <message>” Send an “emote” message in the third person.
        case usageMe = "usageme"
        /// Usage: “/mod <username>” Grant mod status to a user. Use “/mods” to list the moderators of this channel.
        case usageMod = "usagemod"
        /// Usage: “/mods” Lists the moderators of this channel.
        case usageMods = "usagemods"
        /// Usage: “/r9kbetaoff” Disables r9k mode.
        case usageR9kOff = "usager9koff"
        /// Usage: “/r9kbeta” Enables r9k mode. Use “/r9kbetaoff“ to disable.
        case usageR9kOn = "usager9kon"
        /// Usage: “/raid <channel>” Raid another channel. Use “/unraid” to cancel the Raid.
        case usageRaid = "usageraid"
        /// Usage: “/slowoff” Disables slow mode.
        case usageSlowOff = "usageslowoff"
        /// Usage: “/slow [duration]” Enables slow mode (limit how often users may send messages). Duration (optional, default=<number>) must be a positive integer number of seconds. Use “/slowoff” to disable.
        case usageSlowOn = "usageslowon"
        /// Usage: “/subscribersoff” Disables subscribers-only mode.
        case usageSubsOff = "usagesubsoff"
        /// Usage: “/subscribers” Enables subscribers-only mode (only subscribers may chat in this channel). Use “/subscribersoff” to disable.
        case usageSubsOn = "usagesubson"
        /// Usage: “/timeout <username> [duration][time unit] [reason]"Temporarily prevent a user from chatting. Duration (optional, default=10 minutes) must be a positive integer; time unit (optional, default=s) must be one of s, m, h, d, w
        /// maximum duration is 2 weeks. Combinations like 1d2h are also allowed. Reason is optional and will be shown to the target user and other moderators. Use “untimeout” to remove a timeout.
        case usageTimeout = "usagetimeout"
        /// Usage: “/unban <username>” Removes a ban on a user.
        case usageUnban = "usageunban"
        /// Usage: “/unhost” Stop hosting another channel.
        case usageUnhost = "usageunhost"
        /// Usage: “/unmod <username>” Revoke mod status from a user. Use “/mods” to list the moderators of this channel.
        case usageUnmod = "usageunmod"
        /// Usage: “/unraid” Cancel the Raid.
        case usageUnraid = "usageunraid"
        /// Usage: “/untimeout <username>” Removes a timeout on a user.
        case usageUntimeout = "usageuntimeout"
        /// Usage: “/vip <username>” Grant VIP status to a user. Use “/vips” to list the moderators of this channel.
        case usageVip = "usagevip"
        /// Usage: “/vips” Lists the VIPs of this channel.
        case usageVips = "usagevips"
        /// You have added <user> as a VIP of this channel.
        case vipSuccess = "vipsuccess"
        /// The VIPs of this channel are: <list of users>.
        case vipsSuccess = "vipssuccess"
        /// You have been banned from sending whispers.
        case whisperBanned = "whisperbanned"
        /// That user has been banned from receiving whispers.
        case whisperBannedRecipient = "whisperbannedrecipient"
        /// Usage: <login> <message>
        case whisperInvalidArgs = "whisperinvalidargs"
        /// No user matching that login.
        case whisperInvalidLogin = "whisperinvalidlogin"
        /// You cannot whisper to yourself.
        case whisperInvalidSelf = "whisperinvalidself"
        /// You are sending whispers too fast. Try again in a minute.
        case whisperLimitPerMin = "whisperlimitpermin"
        /// You are sending whispers too fast. Try again in a second.
        case whisperLimitPerSec = "whisperlimitpersec"
        /// Your settings prevent you from sending this whisper.
        case whisperRestricted = "whisperrestricted"
        /// That user's settings prevent them from receiving this whisper.
        case whisperRestrictedRecipient = "whisperrestrictedrecipient"
        
        private static let casesStorage: [String: Self] = .init(
            uniqueKeysWithValues: allCases.map({ (key: $0.rawValue, value: $0) })
        )
        
        /// Tries to initialize a `MessageID` using the `rawValue`.
        /// Doesn't respect dashes.
        public init? (rawValue: String) {
            let rawValueWithoutDashes = rawValue.filter({ $0 != "_" })
            if let enumCase = Self.casesStorage[rawValueWithoutDashes] {
                self = enumCase
            } else {
                return nil
            }
        }
    }
    
    public enum Kind {
        case global(
            /// The notice's message.
            message: String
        )
        case local(
            /// The channel's lowercased name.
            channel: String,
            /// The notice's message.
            message: String,
            /// The notice's identifier.
            messageId: MessageID
        )
    }
    
    /// The notice's kind. Also contains the related info.
    public var kind: Kind!
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        if contentLhs.count > 10,
           contentRhs.first == "#",
           contentLhs.hasPrefix("@msg-id="),
           let (channel, message) = contentRhs.dropFirst().componentsOneSplit(separatedBy: " :") {
            let messageIdValue = String(contentLhs.dropFirst(8).dropLast(2))
            guard let messageId = MessageID(rawValue: messageIdValue) else {
                return nil
            }
            self.kind = .local(
                channel: String(channel),
                message: String(message),
                messageId: messageId
            )
        } else if let (star, message) = contentRhs.componentsOneSplit(separatedBy: " :"),
                  star == "*" {
            self.kind = .global(message: message)
        } else {
            return nil
        }
    }
}

// MARK: - Sendable conformances
#if swift(>=5.5)
extension Notice: Sendable { }
extension Notice.MessageID: Sendable { }
extension Notice.Kind: Sendable { }
#endif
