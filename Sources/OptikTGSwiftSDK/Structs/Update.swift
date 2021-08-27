//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct Update : Codable {
    public let update_id: UInt
    public let message: Message?
    public let my_chat_member: ChatMember?

    private enum Keys: String, CodingKey {
        case update_id, message, my_chat_member
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        update_id = try container.decode(UInt.self, forKey: .update_id)
        message = try container.decode(Message.self, forKey: .message)
        my_chat_member = try container.decode(ChatMember.self, forKey: .my_chat_member)
    }
}
