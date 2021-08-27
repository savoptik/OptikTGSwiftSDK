//
// Created by Артём Семёнов on 27.08.2021.
//

import Foundation

public struct User : UserProtocol {
    public let id: UInt
        public let is_bot: Bool
    public let first_name: String
    public let username: String
}
