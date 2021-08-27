//
// Created by Артём Семёнов on 19.07.2021.
//

import Foundation

public struct Message : Codable {
        public let message_id: UInt
        public let from: From
        public let chat: Chat
        public let date: Date
        public let text: String?
        public let new_chat_participant: User?
        public let new_chat_member: User?
        public let new_chat_members: [User]?
        public let entities: [Entitie]?

        private enum Keys : String, CodingKey {
                case message_id, from, chat, date, text, entities, new_chat_member, new_chat_participant, new_chat_members
        }

        public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: Keys.self)
                message_id = try container.decode(UInt.self, forKey: .message_id)
                from = try container.decode(From.self, forKey: .from)
                chat = try container.decode(Chat.self, forKey: .chat)
                let uTime = try  container.decode(Double.self, forKey: .date)
                date = Date(timeIntervalSince1970: uTime)
                text = try container.decode(String.self, forKey: .text)
                entities = try container.decode([Entitie].self, forKey: .entities)
                new_chat_participant = try container.decode(User.self, forKey: .new_chat_participant)
                new_chat_member = try container.decode(User.self, forKey: .new_chat_member)
                new_chat_members = try container.decode([User].self, forKey: .new_chat_members)
        }
}
