//
//  WebSocketManager.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/11.
//

import Foundation

protocol WebSocketConnection {
    func send(with msg: SocketMessage)
    func send(text: String)
    func connect()
    func disConnect()
    var delegate: WebSocketConnectionDelegate? {
        get
        set
    }
}
class WebSocketTaskConnection : NSObject, WebSocketConnection, URLSessionWebSocketDelegate {
    
    // MARK: - Delegate
    var delegate: WebSocketConnectionDelegate?
    var webSocketTask: URLSessionWebSocketTask!
    var urlSession: URLSession!
    let delegateQueue = OperationQueue()
    
    // MARK: - Properties
    
    init(url: URL){
        super.init()
        urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: delegateQueue)
        webSocketTask = urlSession.webSocketTask(with: url)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        self.delegate?.onConnected(connection: self)
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.delegate?.onDisconnected(connection: self, error: nil)
    }
    func connect(){
        webSocketTask.resume()
        listen()
    }
    func disConnect(){
        webSocketTask.cancel(with: .goingAway, reason: nil)
    }
    func listen()  {
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                self.delegate?.onError(connection: self, error: error)
            case .success(let message):
                switch message {
                case .string(let text):
                    self.delegate?.onMessage(connection: self, string: text)
                case .data(let data):
                    self.delegate?.onMessage(connection: self, data: data)
                @unknown default:
                    print("unknown message received")
                }
                self.listen()
            }
        }
    }
    /*
    func send(with msg: SocketMessage){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(msg)
            let message = URLSessionWebSocketTask.Message.data(data)
            
            webSocketTask.send(message){ error in
                if let error = error {
                    self.delegate?.onError(connection: self, error: error)
                }
            }
        } catch {
            print(error)
        }
    }
 */
    func send(with msg: SocketMessage){
        let text = "{\"type\":\"\(msg.type)\", \"gameId\": \(msg.gameId), \"teamId\": \(msg.teamId)}"
        print(text)
        send(text: text)
    }
    func send(text: String) {
        webSocketTask.send(URLSessionWebSocketTask.Message.string(text)) { error in
            if let error = error {
                self.delegate?.onError(connection: self, error: error)
            }
        }
    }
    
    func sendPing() {
        webSocketTask.sendPing { (error) in
            if let error = error {
                print("Sending PING failed: \(error)")
            } else{
                print("Sending PING success: Web Socket connection is alive")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.sendPing()
            }
        }
    }
}
