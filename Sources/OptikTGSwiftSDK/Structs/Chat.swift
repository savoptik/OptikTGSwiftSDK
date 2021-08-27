//
// Created by Артём Семёнов on 20.07.2021.
//

import Foundation

public struct Chat : Codable {
    public let id: UInt
    public let                first_name: String?
    public let last_name: String?
    public let username: String?
    let type: String
    public let title: String?
    public let all_members_are_administrators: Bool?
   }
