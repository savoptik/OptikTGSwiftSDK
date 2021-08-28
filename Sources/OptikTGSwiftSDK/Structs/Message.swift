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
}
