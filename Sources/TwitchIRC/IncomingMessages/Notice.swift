
/// A Twitch `NOTICE` message.
public struct Notice {
    
    public enum MessageID: String {
        case already_banned
        case already_emote_only_off
        case already_emote_only_on
        case already_r9k_off
        case already_r9k_on
        case already_subs_off
        case already_subs_on
        case bad_ban_admin
        case bad_ban_anon
        case bad_ban_broadcaster
        case bad_ban_global_mod
        case bad_ban_mod
        case bad_ban_self
        case bad_ban_staff
        case bad_commercial_error
        case bad_delete_message_broadcaster
        case bad_delete_message_mod
        case bad_host_error
        case bad_host_hosting
        case bad_host_rate_exceeded
        case bad_host_rejected
        case bad_host_self
        case bad_marker_client
        case bad_mod_banned
        case bad_mod_mod
        case bad_slow_duration
        case bad_timeout_admin
        case bad_timeout_anon
        case bad_timeout_broadcaster
        case bad_timeout_duration
        case bad_timeout_global_mod
        case bad_timeout_mod
        case bad_timeout_self
        case bad_timeout_staff
        case bad_unban_no_ban
        case bad_unhost_error
        case bad_unmod_mod
        case ban_success
        case cmds_available
        case color_changed
        case commercial_success
        case delete_message_success
        case emote_only_off
        case emote_only_on
        case followers_off
        case followers_on
        case followers_on_zero
        case host_off
        case host_on
        case host_success
        case host_success_viewers
        case host_target_went_offline
        case hosts_remaining
        case invalid_user
        case mod_success
        case msg_banned
        case msg_banned_email_alias
        case msg_bad_characters
        case msg_channel_blocked
        case msg_channel_suspended
        case msg_duplicate
        case msg_emoteonly
        case msg_facebook
        case msg_followersonly
        case msg_followersonly_followed
        case msg_followersonly_zero
        case msg_r9k
        case msg_ratelimit
        case msg_rejected
        case msg_rejected_mandatory
        case msg_requires_verified_phone_number
        case msg_room_not_found
        case msg_slowmode
        case msg_subsonly
        case msg_suspended
        case msg_timedout
        case msg_verified_email
        case no_help
        case no_mods
        case not_hosting
        case no_permission
        case r9k_off
        case r9k_on
        case raid_error_already_raiding
        case raid_error_forbidden
        case raid_error_self
        case raid_error_too_many_viewers
        case raid_error_unexpected
        case raid_notice_mature
        case raid_notice_restricted_chat
        case room_mods
        case slow_off
        case slow_on
        case subs_off
        case subs_on
        case timeout_no_timeout
        case timeout_success
        case tos_ban
        case turbo_only_color
        case unban_success
        case unmod_success
        case unraid_error_no_active_raid
        case unraid_error_unexpected
        case unraid_success
        case unrecognized_cmd
        case unsupported_chatrooms_cmd
        case untimeout_banned
        case untimeout_success
        case usage_ban
        case usage_clear
        case usage_color
        case usage_commercial
        case usage_disconnect
        case usage_emote_only_off
        case usage_emote_only_on
        case usage_followers_off
        case usage_followers_on
        case usage_help
        case usage_host
        case usage_marker
        case usage_me
        case usage_mod
        case usage_mods
        case usage_r9k_off
        case usage_r9k_on
        case usage_raid
        case usage_slow_off
        case usage_slow_on
        case usage_subs_off
        case usage_subs_on
        case usage_timeout
        case usage_unban
        case usage_unhost
        case usage_unmod
        case usage_unraid
        case usage_untimeout
        case whisper_banned
        case whisper_banned_recipient
        case whisper_invalid_args
        case whisper_invalid_login
        case whisper_invalid_self
        case whisper_limit_per_min
        case whisper_limit_per_sec
        case whisper_restricted
        case whisper_restricted_recipient
    }
    
    /// The channel's lowercased name.
    public var channel = String()
    /// The notice's message.
    public var message = String()
    /// The notice's identifier.
    public var messageId: MessageID!
    
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
