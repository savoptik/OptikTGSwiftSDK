//
// Created by Артём Семёнов on 19.07.2021.
//

import Foundation

public struct Message : Decodable {
        public let message_id: UInt
        public let from: From
        public let chat: Chat
        public let date: Date
        public let text: String

        private enum Keys : String, CodingKey {
                case message_id, from, chat, date, text
        }

        public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: Keys.self)
                message_id = try container.decode(UInt.self, forKey: .message_id)
                from = try container.decode(From.self, forKey: .from)
                chat = try container.decode(Chat.self, forKey: .chat)
                let uTime = try  container.decode(Double.self, forKey: .date)
                date = Date(timeIntervalSince1970: uTime)
                text = try container.decode(String.self, forKey: .text)
        }
}
