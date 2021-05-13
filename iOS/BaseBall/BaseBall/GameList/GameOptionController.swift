//
//  GameOptionViewController.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/04.
//

import UIKit

class GameOptionController: UIViewController {
    
    @IBOutlet weak var homeTeam: UIButton!
    @IBOutlet weak var awayTeam: UIButton!
    
    var game: Game?
    var socket : WebSocketTaskConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        socket = WebSocketTaskConnection(url: SocketEndPoint.baseURL)
        socket?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        socket?.connect()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    @IBAction func didSelectHome(_ sender: UIButton) {
        guard let game = game  else { return }
        let joinMessage = SocketMessage(type: "join", gameId: game.gameId, teamId: game.homeTeam.teamId)
        let occupyMessage = SocketMessage(type: "occupy", gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: joinMessage)
        socket?.send(with: occupyMessage)
        
        let outMessage = SocketMessage(type: "out", gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: outMessage)
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
        guard let game = game  else { return }
        let joinMessage = SocketMessage(type: "join", gameId: game.gameId, teamId: game.awayTeam.teamId)
        let occupyMessage = SocketMessage(type: "occupy", gameId: game.gameId, teamId: game.awayTeam.teamId)
        socket?.send(with: joinMessage)
        socket?.send(with: occupyMessage)
        
        let outMessage = SocketMessage(type: "out", gameId: game.gameId, teamId: game.awayTeam.teamId)
        socket?.send(with: outMessage)
    }
    func moveGameMatchingView(){
        let gameMatchingViewController = self.storyboard?.instantiateViewController(identifier: "GameMatching")as! MatchingViewController
        gameMatchingViewController.transitioningDelegate = self
        gameMatchingViewController.game = game
        gameMatchingViewController.socket = socket
        self.present(gameMatchingViewController, animated: true, completion: nil)
    }
    func configureButton(){
        homeTeam.setTitle(game?.homeTeam.name, for: .normal)
        awayTeam.setTitle(game?.awayTeam.name, for: .normal)
        /*
        if game?.homeTeam.occupied == true {
            homeTeam.isEnabled = false
        }
        
        if game?.awayTeam.occupied == true  {
            awayTeam.isEnabled = false
        }*/
    }
}
extension GameOptionController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MatchingTransitioner(duration: 0.2, animationType: .present)
    }
}
extension GameOptionController : WebSocketConnectionDelegate {
    
    func onConnected(connection: WebSocketConnection) {
        print("connected")
    }
    
    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        print("disconnected")
    }
    
    func onError(connection: WebSocketConnection, error: Error) {
        print(error.localizedDescription)
        let code = (error as NSError).code
        print(code)
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print(data)
    }
    func onMessage(connection: WebSocketConnection, string: String) {
        print(string)
        if string ==  "\"join\"" {
            DispatchQueue.main.sync {
                moveGameMatchingView()
            }
        }
    }
}
