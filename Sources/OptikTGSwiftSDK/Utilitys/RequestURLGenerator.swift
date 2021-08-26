//
// Created by Артём Семёнов on 17.07.2021.
//

import Foundation

struct RequestURLGenerator {
    private let scheme = "https"
    private let host = "api.telegram.org"
    private let path: String

    init(WithToken token: Token) {
        path = "/bot\(token.token)/"
    }

    private func requestString(WithMethod method: String) -> URLComponents {
        return {
            var components = URLComponents()
            components.scheme = self.scheme
            components.host = self.host
            components.path = self.path + method
            return components
        }()
    }

    func getMe() -> URL? {
        return requestString(WithMethod: "getMe").url
    }

    func getUpdates() -> URL? {
        return requestString(WithMethod: "getUpdates").url
    }

    func sendMessage(WithMessage message: OutMessage) -> URL? {
        return {
            var components = requestString(WithMethod: "sendMessage")
            components.queryItems = [
                URLQueryItem(name: "chat_id", value: "\(message.chat_id)"),
                URLQueryItem(name: "text", value: message.text)
            ]
            if let disable_notification = message.disable_notification {
                components.queryItems?.append(URLQueryItem(name: "disable_notification", value: "\(disable_notification)"))
            }
            if let reply_to_message_id = message.reply_to_message_id {
                components.queryItems?.append(URLQueryItem(name: "reply_to_message_id", value: "\(reply_to_message_id)"))
            }
            if let allow_sending_without_reply = message.allow_sending_without_reply {
                components.queryItems?.append(URLQueryItem(name: "allow_sending_without_reply", value: "\(allow_sending_without_reply)"))
            }
            return components.url
        }()
}

}
