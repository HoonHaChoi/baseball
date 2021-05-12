//
//  SocketManagerDelegate.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import Foundation

protocol WebSocketConnectionDelegate {
    func onConnected(connection: WebSocketConnection)
    func onDisconnected(connection: WebSocketConnection, error: Error?)
    func onError(connection: WebSocketConnection, error: Error)
    func onMessage(connection: WebSocketConnection, string: String)
    func onMessage(connection: WebSocketConnection, data: Data)
}
