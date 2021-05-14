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
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        socket = WebSocketTaskConnection(url: SocketEndPoint.baseURL)
        socket?.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        socket?.connect()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let game = game  else { return }
        let outMessage = SocketMessage(type: SocketRequest.out, gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: outMessage)
        socket?.disConnect()
        
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    // MARK: - User Action Handler
    
    @IBAction func didSelectHome(_ sender: UIButton) {
        guard let game = game else { return }
        
        let joinMessage = SocketMessage(type: SocketRequest.join, gameId: game.gameId, teamId: game.homeTeam.teamId)
        let occupyMessage = SocketMessage(type: SocketRequest.occupy, gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: joinMessage)
        socket?.send(with: occupyMessage)
        
        moveGameMatchingView(game: game.gameId, with: game.homeTeam)
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
        guard let game = game else { return }
        
        let joinMessage = SocketMessage(type: SocketRequest.join, gameId: game.gameId, teamId: game.awayTeam.teamId)
        let occupyMessage = SocketMessage(type: SocketRequest.occupy, gameId: game.gameId, teamId: game.awayTeam.teamId)
        socket?.send(with: joinMessage)
        socket?.send(with: occupyMessage)
        
        moveGameMatchingView(game: game.gameId, with: game.awayTeam)
    }
}

extension GameOptionController {
    func moveGameMatchingView(game : Int, with team : Team){
        let gameMatchingViewController = self.storyboard?.instantiateViewController(identifier: "GameMatching")as! MatchingViewController
        gameMatchingViewController.transitioningDelegate = self
        gameMatchingViewController.gameId = game
        gameMatchingViewController.team = team
        gameMatchingViewController.socket = socket
        self.present(gameMatchingViewController, animated: true, completion: nil)
    }
    func configureButton(){
        homeTeam.setTitle(game?.homeTeam.name, for: .normal)
        awayTeam.setTitle(game?.awayTeam.name, for: .normal)
    
        if game?.homeTeam.occupied == true {
            homeTeam.isEnabled = false
        }
        
        if game?.awayTeam.occupied == true  {
            awayTeam.isEnabled = false
        }
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
    }
    
    func onMessage(connection: WebSocketConnection, data: Data) {
        print(data)
    }
    func onMessage(connection: WebSocketConnection, string: String) {
        print(string)
    }
}
