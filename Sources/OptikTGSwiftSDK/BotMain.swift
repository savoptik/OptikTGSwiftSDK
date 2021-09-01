//
// Created by Артём Семёнов on 04.08.2021.
//

import Foundation

#if os(Linux)
import FoundationNetworking
#endif

public var TGBOT = BotMain()

public class BotMain {
    public var botDelegate: BotDelegate? = nil
    private var runing: Bool = true
    private var updateIDStack: [UInt] = []
    private let semaphore = DispatchSemaphore(value: 0)
    public var isRuning: Bool {
        get {
            return runing
        }
    }


    public init() {

    }

    public convenience init(WithDelegate delegate: BotDelegate) {
        self.init()
        botDelegate = delegate
    }

    final public func run(commandLineArguments: [String]) {
        runing = check(commandLineArguments: commandLineArguments)
        if runing {

            guard let delegat = botDelegate else {
                return
            }

            if let handler = delegat.signalHandler {
                for i: Int32 in 1..<7 {
                    signal(i, handler)
                }
            } else {
                for i: Int32 in 1..<7 {
                    signal(i) { int32 in
                        print("fail code: \(int32)")
                        TGBOT.stopBot()
                        exit(int32)
                    }
                }
            }

            delegat.botDedLoad(commandLineArguments: commandLineArguments)

            while runing {
                semaphore.resume()
                updateRequest(delegat: delegat)
                semaphore.wait()
            }

            delegat.botDedTerminate(commandLineArguments: commandLineArguments)

        } else {
            print("Bot ID check faild")
        }
    }

    private func check(commandLineArguments: [String]) -> Bool {
        if let delegate = botDelegate {
            return checkRequest(delegat: delegate)
        }
        print("Delegat not setting")

        return false
    }

    private func checkRequest(delegat: BotDelegate) -> Bool {
        var checkd: Bool = false

        let session = URLSession.shared
        let sim = DispatchSemaphore(value: 0)

        guard let url = RequestURLGenerator(WithToken: delegat.token).getMe() else {
            print("Fale bot check url constructing")
            return false
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let localData = data {
                do {
                    let res: ResponseGetMe = try JSONDecoder().decode(ResponseGetMe.self, from: localData)
                    checkd = res.ok
                } catch {
                    checkd = false
                }

            }
            sim.signal()
        }
        task.resume()
        sim.wait()

        return checkd
    }

    private func updateRequest(delegat: BotDelegate) {
        let session = URLSession.shared

        guard let url = RequestURLGenerator(WithToken: delegat.token).getUpdates() else {
            fatalError("Fale update url constructing")
        }

        let task: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
            if let localData = data {
                do {
                    let res: ResponseGetUpdates = try JSONDecoder().decode(ResponseGetUpdates.self, from: localData)
                    if res.ok {
                        DispatchQueue.global(qos: .default).async { [self] in
                            let unikUpdates: [Update] = res.result.filter {!self.updateIDStack.contains($0.update_id)}
                            self.updateIDStack.append(contentsOf: unikUpdates.map {$0.update_id})
                            for handler in delegat.handlers {
                                DispatchQueue.global(qos: .background).async { [handler, unikUpdates] in
                                    handler(unikUpdates)
                                }
                            }
                            self.semaphore.signal()
                        }
                    } else {
                        self.semaphore.signal()
                    }
                } catch {
                    print("Fail decoding update")
                    var components = URLComponents()
                    components.scheme = "file"
                    components.path = FileManager.default.currentDirectoryPath  + "/update.json"
                    if let url = components.url {
                        do {
                            try localData.write(to: url)
                        } catch {
                            print("kan not write data to file")
                        }
                    }
                    fatalError()
                }
            } else {
                self.semaphore.signal()
            }
        }
        task.resume()
    }

    public func stopBot() {
        self.runing = false
        self.semaphore.signal()
    }

    final public func setDelegate(_ delegate: BotDelegate) -> BotMain {
        self.botDelegate = delegate
        return self
    }

    final public func sendMessage(withMessage message: OutMessage) {
    guard let delegate = self.botDelegate else {
    print("Delegate has not implementated")
    return
}

        guard let url = RequestURLGenerator(WithToken: delegate.token).sendMessage(WithMessage: message) else {
        print("error sendeng message url construction")
return
}

let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let err = error {
            print("error sending message: \(err)")
        }
    }
        task.resume()
}

    final public func sendMessage(WithChatID chatId: Int, andText text: String, disable_notification: Bool? = nil, reply_to_message_id: UInt? = nil, allow_sending_without_reply: Bool? = nil) {
        self.sendMessage(withMessage: .init(chat_id: chatId, text: text, disable_notification: disable_notification, reply_to_message_id: reply_to_message_id, allow_sending_without_reply: allow_sending_without_reply))
    }
}
