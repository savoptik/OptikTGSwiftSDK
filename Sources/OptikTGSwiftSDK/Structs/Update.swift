//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct Update : Codable {
    public let update_id: UInt
    public let message: Message?
    public let my_chat_member: ChatMember?
}
