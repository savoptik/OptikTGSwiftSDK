//
// Created by Артём Семёнов on 21.08.2021.
//

import Foundation

public struct OutMessage : Encodable {
        public let chat_id: Int
    public let text: String
    public let disable_notification: Bool?
    public let reply_to_message_id: UInt?
    public let allow_sending_without_reply: Bool?

    enum Keys : CodingKey {
        case chat_id, text, reply_to_message_id, allow_sending_without_reply, disable_notification
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(chat_id, forKey: .chat_id)
        try container.encode(text, forKey: .text)
        try container.encode(reply_to_message_id, forKey: .reply_to_message_id)
        try container.encode(disable_notification, forKey: .disable_notification)
        try container.encode(allow_sending_without_reply, forKey: .allow_sending_without_reply)
    }

}
