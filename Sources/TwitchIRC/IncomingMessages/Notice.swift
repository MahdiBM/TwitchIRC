
/// A Twitch `NOTICE` message.
public struct Notice {
    
    public enum MessageID: String {
        /// <user> is already banned in this channel.
        case already_banned
        /// This room is not in emote-only mode.
        case already_emote_only_off
        /// This room is already in emote-only mode.
        case already_emote_only_on
        /// This room is not in r9k mode.
        case already_r9k_off
        /// This room is already in r9k mode.
        case already_r9k_on
        /// This room is not in subscribers-only mode.
        case already_subs_off
        /// This room is already in subscribers-only mode.
        case already_subs_on
        /// You cannot ban admin <user>. Please email support@twitch.tv if an admin is being abusive.
        case bad_ban_admin
        /// You cannot ban anonymous users.
        case bad_ban_anon
        /// You cannot ban the broadcaster.
        case bad_ban_broadcaster
        /// You cannot ban global moderator <user>. Please email support@twitch.tv if a global moderator is being abusive.
        case bad_ban_global_mod
        /// You cannot ban moderator <user> unless you are the owner of this channel.
        case bad_ban_mod
        /// You cannot ban yourself.
        case bad_ban_self
        /// You cannot ban a staff <user>. Please email support@twitch.tv if a staff member is being abusive.
        case bad_ban_staff
        /// Failed to start commercial.
        case bad_commercial_error
        /// You cannot delete the broadcaster's messages.
        case bad_delete_message_broadcaster
        /// Failed to delete message.
        case bad_delete_message_error
        /// You cannot delete messages from another moderator <user>.
        case bad_delete_message_mod
        /// There was a problem hosting <channel>. Please try again in a minute.
        case bad_host_error
        /// This channel is already hosting <channel>.
        case bad_host_hosting
        /// Host target cannot be changed more than <number> times every half hour.
        case bad_host_rate_exceeded
        /// This channel is unable to be hosted.
        case bad_host_rejected
        /// A channel cannot host itself.
        case bad_host_self
        /// Sorry, /marker is not available through this client.
        case bad_marker_client
        /// <user> is banned in this channel. You must unban this user before granting mod status.
        case bad_mod_banned
        /// <user> is already a moderator of this channel.
        case bad_mod_mod
        /// You cannot set slow delay to more than <number> seconds.
        case bad_slow_duration
        /// You cannot timeout admin <user>. Please email support@twitch.tv if an admin is being abusive.
        case bad_timeout_admin
        /// You cannot timeout anonymous users.
        case bad_timeout_anon
        /// You cannot timeout the broadcaster.
        case bad_timeout_broadcaster
        /// You cannot time a user out for more than <seconds>.
        case bad_timeout_duration
        /// You cannot timeout global moderator <user>. Please email support@twitch.tv if a global moderator is being abusive.
        case bad_timeout_global_mod
        /// You cannot timeout moderator <user> unless you are the owner of this channel.
        case bad_timeout_mod
        /// You cannot timeout yourself.
        case bad_timeout_self
        /// You cannot timeout staff <user>. Please email support@twitch.tv if a staff member is being abusive.
        case bad_timeout_staff
        /// <user> is not banned from this channel.
        case bad_unban_no_ban
        /// There was a problem exiting host mode. Please try again in a minute.
        case bad_unhost_error
        /// <user> is not a moderator of this channel.
        case bad_unmod_mod
        /// <user> is not a VIP of this channel.
        case bad_unvip_grantee_not_vip
        /// Unable to add VIP. Visit the Achievements page on your dashboard to learn how to unlock this feature.
        case bad_vip_achievement_incomplete
        /// <user> is already a VIP of this channel.
        case bad_vip_grantee_already_vip
        /// <user> is banned in this channel. You must unban this user before granting VIP status.
        case bad_vip_grantee_banned
        /// Unable to add VIP. Visit the Achievements page on your dashboard to learn how to unlock additional VIP slots.
        case bad_vip_max_vips_reached
        /// <user> is now banned from this channel.
        case ban_success
        /// Commands available to you in this room (use /help <command> for details): <list of commands>
        case cmds_available
        /// Your color has been changed.
        case color_changed
        /// Initiating <number> second commercial break. Keep in mind that your stream is still live and not everyone will get a commercial.
        case commercial_success
        /// The message from <user> is now deleted.
        case delete_message_success
        /// This room is no longer in emote-only mode.
        case emote_only_off
        /// This room is now in emote-only mode.
        case emote_only_on
        /// This room is no longer in followers-only mode. Note: The followers tags are broadcast to a channel when a moderator makes changes.
        case followers_off
        /// This room is now in <duration> followers-only mode. Examples: “This room is now in 2 week followers-only mode.” or “This room is now in 1 minute followers-only mode.”
        case followers_on
        /// This room is now in followers-only mode.
        case followers_onzero
        /// Exited host mode.
        case host_off
        /// Now hosting <channel>.
        case host_on
        /// <user> is now hosting you.
        case host_success
        /// <user> is now hosting you for up to <number> viewers.
        case host_success_viewers
        /// <channel> has gone offline. Exiting host mode.
        case host_target_went_offline
        /// <number> host commands remaining this half hour.
        case hosts_remaining
        /// Invalid username: <user>
        case invalid_user
        /// You have added <user> as a moderator of this channel.
        case mod_success
        /// You are permanently banned from talking in <channel>.
        case msg_banned
        /// Your message was not sent because it contained too many characters that could not be processed. If you believe this is an error, rephrase and try again.
        case msg_bad_characters
        /// Your message was not sent because your email address is banned from this channel.
        case msg_banned_email_alias
        /// Your message was not sent because your account is not in good standing in this channel.
        case msg_channel_blocked
        /// This channel has been suspended.
        case msg_channel_suspended
        /// Your message was not sent because it is identical to the previous one you sent, less than 30 seconds ago.
        case msg_duplicate
        /// This room is in emote only mode. You can find your currently available emoticons using the smiley in the chat text area.
        case msg_emoteonly
        /// You must use Facebook Connect to send messages to this channel. You can see Facebook Connect in your Twitch settings under the connections tab.
        case msg_facebook
        /// This room is in <duration> followers-only mode. Follow <channel> to join the community!Note: These msg_followers tags are kickbacks to a user who does not meet the criteria; that is, does not follow or has not followed long enough.
        case msg_followersonly
        /// This room is in <duration1> followers-only mode. You have been following for <duration2>. Continue following to chat!
        case msg_followersonly_followed
        /// This room is in followers-only mode. Follow <channel> to join the community!
        case msg_followersonly_zero
        /// This room is in r9k mode and the message you attempted to send is not unique.
        case msg_r9k
        /// Your message was not sent because you are sending messages too quickly.
        case msg_ratelimit
        /// Hey! Your message is being checked by mods and has not been sent.
        case msg_rejected
        /// Your message wasn't posted due to conflicts with the channel's moderation settings.
        case msg_rejected_mandatory
        /// A verified phone number is required to chat in this channel. Please visit https://www.twitch.tv/settings/security to verify your phone number.
        case msg_requires_verified_phone_number
        /// The room was not found.
        case msg_room_not_found
        /// This room is in slow mode and you are sending messages too quickly. You will be able to talk again in <number> seconds.
        case msg_slowmode
        /// This room is in subscribers only mode. To talk, purchase a channel subscription at https://www.twitch.tv/products/<broadcaster login name>/ticket?ref=subscriber_only_mode_chat.
        case msg_subsonly
        /// Your account has been suspended.
        case msg_suspended
        /// You are banned from talking in <channel> for <number> more seconds.
        case msg_timedout
        /// This room requires a verified email address to chat. Please verify your email at https://www.twitch.tv/settings/profile.
        case msg_verified_email
        /// No help available.
        case no_help
        /// There are no moderators of this channel.
        case no_mods
        /// No channel is currently being hosted.
        case not_hosting
        /// You don’t have permission to perform that action.
        case no_permission
        /// This channel does not have any VIPs.
        case no_vips
        /// This room is no longer in r9k mode.
        case r9k_off
        /// This room is now in r9k mode.
        case r9k_on
        /// You already have a raid in progress.
        case raid_error_already_raiding
        /// You cannot raid this channel.
        case raid_error_forbidden
        /// A channel cannot raid itself.
        case raid_error_self
        /// Sorry, you have more viewers than the maximum currently supported by raids right now.
        case raid_error_too_many_viewers
        /// There was a problem raiding <channel>. Please try again in a minute.
        case raid_error_unexpected
        /// This channel is intended for mature audiences.
        case raid_notice_mature
        /// This channel has follower or subscriber only chat.
        case raid_notice_restricted_chat
        /// The moderators of this channel are: <list of users>
        case room_mods
        /// This room is no longer in slow mode.
        case slow_off
        /// This room is now in slow mode. You may send messages every <number> seconds.
        case slow_on
        /// This room is no longer in subscribers-only mode.
        case subs_off
        /// This room is now in subscribers-only mode.
        case subs_on
        /// <user> is not timed out from this channel.
        case timeout_no_timeout
        /// <user> has been timed out for <duration> seconds.
        case timeout_success
        /// The community has closed channel <channel> due to Terms of Service violations.
        case tos_ban
        /// Only turbo users can specify an arbitrary hex color. Use one of the following instead: <list of colors>.
        case turbo_only_color
        /// <user> is no longer banned from this channel.
        case unban_success
        /// You have removed <user> as a moderator of this channel.
        case unmod_success
        /// You do not have an active raid.
        case unraid_error_no_active_raid
        /// There was a problem stopping the raid. Please try again in a minute.
        case unraid_error_unexpected
        /// The raid has been cancelled.
        case unraid_success
        /// Unrecognized command: <command>
        case unrecognized_cmd
        /// The command <command> cannot be used in a chatroom.
        case unsupported_chatrooms_cmd
        /// <user> is permanently banned. Use "/unban" to remove a ban.
        case untimeout_banned
        /// <user> is no longer timed out in this channel.
        case untimeout_success
        /// You have removed <user> as a VIP of this channel.
        case unvip_success
        /// Usage: “/ban <username> [reason]” Permanently prevent a user from chatting. Reason is optional and will be shown to the target and other moderators. Use “/unban” to remove a ban.
        case usage_ban
        /// Usage: “/clear” Clear chat history for all users in this room.
        case usage_clear
        /// Usage: “/color <color>” Change your username color. Color must be in hex (#000000) or one of the following: Blue, BlueViolet, CadetBlue, Chocolate, Coral, DodgerBlue, Firebrick, GoldenRod, Green, HotPink, OrangeRed, Red, SeaGreen, SpringGreen, YellowGreen.
        case usage_color
        /// Usage: “/commercial [length]” Triggers a commercial. Length (optional) must be a positive number of seconds.
        case usage_commercial
        /// Usage: “/disconnect” Reconnects to chat.
        case usage_disconnect
        /// Usage: “/emoteonlyoff” Disables emote-only mode.
        case usage_emote_only_off
        /// Usage: “/emoteonly” Enables emote-only mode (only emoticons may be used in chat). Use /emoteonlyoff to disable.
        case usage_emote_only_on
        /// Usage: “/followersoff” Disables followers-only mode.
        case usage_followers_off
        /// Usage: “/followers” Enables followers-only mode (only users who have followed for “duration” may chat). Examples: “30m”, “1 week”, “5 days 12 hours”. Must be less than 3 months.
        case usage_followers_on
        /// Usage: “/help” Lists the commands available to you in this room.
        case usage_help
        /// Usage: “/host <channel>” Host another channel. Use “/unhost” to unset host mode.
        case usage_host
        /// Usage: “/marker <optional comment>” Adds a stream marker (with an optional comment, max 140 characters) at the current timestamp. You can use markers in the Highlighter for easier editing.
        case usage_marker
        /// Usage: “/me <message>” Send an “emote” message in the third person.
        case usage_me
        /// Usage: “/mod <username>” Grant mod status to a user. Use “/mods” to list the moderators of this channel.
        case usage_mod
        /// Usage: “/mods” Lists the moderators of this channel.
        case usage_mods
        /// Usage: “/r9kbetaoff” Disables r9k mode.
        case usage_r9k_off
        /// Usage: “/r9kbeta” Enables r9k mode. Use “/r9kbetaoff“ to disable.
        case usage_r9k_on
        /// Usage: “/raid <channel>” Raid another channel. Use “/unraid” to cancel the Raid.
        case usage_raid
        /// Usage: “/slowoff” Disables slow mode.
        case usage_slow_off
        /// Usage: “/slow [duration]” Enables slow mode (limit how often users may send messages). Duration (optional, default=<number>) must be a positive integer number of seconds. Use “/slowoff” to disable.
        case usage_slow_on
        /// Usage: “/subscribersoff” Disables subscribers-only mode.
        case usage_subs_off
        /// Usage: “/subscribers” Enables subscribers-only mode (only subscribers may chat in this channel). Use “/subscribersoff” to disable.
        case usage_subs_on
        /// Usage: “/timeout <username> [duration][time unit] [reason]"Temporarily prevent a user from chatting. Duration (optional, default=10 minutes) must be a positive integer; time unit (optional, default=s) must be one of s, m, h, d, w
        /// maximum duration is 2 weeks. Combinations like 1d2h are also allowed. Reason is optional and will be shown to the target user and other moderators. Use “untimeout” to remove a timeout.
        case usage_timeout
        /// Usage: “/unban <username>” Removes a ban on a user.
        case usage_unban
        /// Usage: “/unhost” Stop hosting another channel.
        case usage_unhost
        /// Usage: “/unmod <username>” Revoke mod status from a user. Use “/mods” to list the moderators of this channel.
        case usage_unmod
        /// Usage: “/unraid” Cancel the Raid.
        case usage_unraid
        /// Usage: “/untimeout <username>” Removes a timeout on a user.
        case usage_untimeout
        /// Usage: “/vip <username>” Grant VIP status to a user. Use “/vips” to list the moderators of this channel.
        case usage_vip
        /// Usage: “/vips” Lists the VIPs of this channel.
        case usage_vips
        /// You have added <user> as a VIP of this channel.
        case vip_success
        /// The VIPs of this channel are: <list of users>.
        case vips_success
        /// You have been banned from sending whispers.
        case whisper_banned
        /// That user has been banned from receiving whispers.
        case whisper_banned_recipient
        /// Usage: <login> <message>
        case whisper_invalid_args
        /// No user matching that login.
        case whisper_invalid_login
        /// You cannot whisper to yourself.
        case whisper_invalid_self
        /// You are sending whispers too fast. Try again in a minute.
        case whisper_limit_per_min
        /// You are sending whispers too fast. Try again in a second.
        case whisper_limit_per_sec
        /// Your settings prevent you from sending this whisper.
        case whisper_restricted
        /// That user's settings prevent them from receiving this whisper.
        case whisper_restricted_recipient
    }
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The notice's message.
    public var message = String()
    /// The notice's identifier.
    public var messageId: MessageID!
    
    public init() { }
    
    init? (contentLhs: String, contentRhs: String) {
        guard contentLhs.count > 10,
              contentRhs.first == "#",
              contentLhs.hasPrefix("@msg-id="),
              let (channel, message) = contentRhs.dropFirst().componentsOneSplit(separatedBy: " :")
        else {
            return nil
        }
        self.channel = String(channel)
        self.message = String(message)
        let messageIdValue = String(contentLhs.dropFirst(8).dropLast(2))
        guard let messageId = MessageID(rawValue: messageIdValue) else {
            return nil
        }
        self.messageId = messageId
    }
    
}
