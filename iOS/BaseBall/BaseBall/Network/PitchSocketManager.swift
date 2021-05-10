//
//  PitchSocketManager.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import Foundation
import SocketIO

class PitchSocketManager {
    // MARK: - Delegate
    weak var delegate : SocketManagerDelegate?
    
    // MARK: - Properties
    let manager = SocketManager(
        socketURL: URL(string: "http://15.164.68.136:8080")!,
        config: [.log(false), .compress])
    
    var socket: SocketIOClient? = nil
    
    init(_ delegate : SocketManagerDelegate){
        self.delegate = delegate
        setupSocket()
        setupSocketEvents()
        socket?.connect()
    }
    func stop(){
        socket?.removeAllHandlers()
    }
    
    // MARK: - Socket Setups
    func setupSocket(){
        self.socket = manager.defaultSocket
    }
    func setupSocketEvents(){
        socket?.on(clientEvent: .connect, callback: { data, ack in
            self.delegate?.didconnect()
        })
        socket?.on("pitch", callback : { data, ack in
            guard let dataInfo = data.first else { return }
            if let response : Pitch = try? SocketParser.convert(data: dataInfo) {
                self.delegate?.didReceive(with: response)
            }
        })
    }
    
    // MARK: - Socket Emits
    func didCallPitch(gameId: Int, teamId: Int){
        let info: [String : Any] = [
            "gameId": gameId,
            "teamId": teamId
        ]
        socket?.emit("pitch", info)
    }
}
