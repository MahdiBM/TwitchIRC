# TwitchIRC
 
A Swift package to take of parsing/serializing Twitch IRC messages for you.

## How To Parse

To parse Twitch messages, use `IncomingMessage.parse(ircOutput:)`:
```swift
/// `websocketOutput` here represents the `String` Twitch sent you over IRC.
let twitchMessages: [(message: IncomingMessage?, text: String)] = IncomingMessage.parse(ircOutput: websocketOutput)
```
Then to use:
```swift
for (message, text) in twitchMessages {
    if let message = message {
        switch message {
        /// Switch over each case of the `IncomingMessage` and do whatever you want.
        }
    }
}
```
As an example, this will print any normal chat messages viewers send, in the channels you've joined:
```swift
for (message, _) in twitchMessages {
    if let message = message {
        switch message {
        case let .privateMessage(privateMessage):
            print("In channel \(privateMessage.channel), user \(privateMessage.displayName) sent a message: \(privateMessage.message)")
        default: break
        }
    }
}
```

## How To Serialize

To serialize your messages to a proper text form, use `OutgoingMessage.serialize()`:
```swift
let outgoingMessage: OutgoingMessage = ...
let serialized = outgoingMessage.serialize()
/// Now send `serialized` to Twitch over IRC.
```
As an example of serializing, this will send a normal chat message to channel `mahdimmbm`, saying `Testing TwitchIRC :)`:
```swift
let outgoingMessage: OutgoingMessage = .privateMessage(to: "mahdimmbm", message: "Testing TwitchIRC :)")
let serialized = outgoingMessage.serialize()
/// Now send `serialized` to Twitch over IRC.
```

## Warning

This package includes both official and unofficial info sent to you over IRC by Twitch.   
Twitch only gurantees the official stuff, and using the unofficial info might result in code breakage in the future.   
To see what's official and what's not, you can take a look at the [official documentation](https://dev.twitch.tv/docs/irc).

## Communication and Support

If you have any questions, [TwitchDev Discord server](https://discord.gg/twitchdev) will likely prove helpful to you. I'm available there @Mahdi BM#0517.   

Feel free to make PRs or open Issues as well :)
