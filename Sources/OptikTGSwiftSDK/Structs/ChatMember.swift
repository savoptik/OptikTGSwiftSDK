//
// Created by Артём Семёнов on 27.08.2021.
//

import Foundation

public struct ChatMember : Codable {
    public let chat: Chat
    public let from: From
    public let date: Date
    public let old_chat_member: MemberChatStatus
    public let new_chat_member: MemberChatStatus
}
