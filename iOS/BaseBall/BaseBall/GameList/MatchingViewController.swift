//
//  MatchingViewController.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import UIKit

class MatchingViewController: UIViewController {
    
    @IBOutlet weak var watingLabel: UILabel!

    var gameId : Int!
    var team : Team!
    var socket : WebSocketTaskConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradiendBackground()
        socket?.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(close))
        self.view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        watingLabel.startFlashing(interval: TimeInterval(0.6))
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let leaveMessage = SocketMessage(type: SocketRequest.leave, gameId: gameId, teamId: team.teamId)
        socket?.send(with: leaveMessage)
    }
    func setGradiendBackground(){
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    private func moveGamePlayView(game : Int, with team : Team) {
        let gamePlayViewController = UIStoryboard(name: "GamePlay", bundle: nil)
            .instantiateViewController(withIdentifier: "GamePlay") as! GamePlayViewController
        gamePlayViewController.modalPresentationStyle = .fullScreen
        gamePlayViewController.gameId = game
        gamePlayViewController.team = team
        gamePlayViewController.socket = socket
        
        self.present(gamePlayViewController, animated: true, completion: nil)
    }
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension MatchingViewController : WebSocketConnectionDelegate {
    
    func onConnected(connection: WebSocketConnection) {
        print("connected")
    }
    
    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        print("disconnected")
    }
    
    func onError(connection: WebSocketConnection, error: Error) {
        print(error.localizedDescription)
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print(data)
    }
    func onMessage(connection: WebSocketConnection, string: String) {
        print(string)
        if string ==  SocketResponse.success{
            DispatchQueue.main.sync {
                moveGamePlayView(game: self.gameId, with: self.team)
            }
        }
    }
}
