//
// Created by Артём Семёнов on 18.07.2021.
//

import Foundation

public struct ResultGetMe: UserProtocol {
    public let id: UInt
    public let is_bot: Bool
    public let first_name: String
    public let username: String
    public let can_join_groups: Bool
    public let can_read_all_group_messages: Bool
    public let supports_inline_queries: Bool

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        id = try container.decode(UInt.self, forKey: .id)
        is_bot = try container.decode(Bool.self, forKey: .is_bot)
        first_name = try container.decode(String.self, forKey: .first_name)
        username = try container.decode(String.self, forKey: .username)
        can_join_groups = try container.decode(Bool.self, forKey: .can_join_groups)
        can_read_all_group_messages = try container.decode(Bool.self, forKey: .can_read_all_group_messages)
        supports_inline_queries = try container.decode(Bool.self, forKey: .supports_inline_queries)
    }

    private enum  Keys : String, CodingKey {
        case id, is_bot, first_name, username, can_join_groups, can_read_all_group_messages, supports_inline_queries
    }
}
