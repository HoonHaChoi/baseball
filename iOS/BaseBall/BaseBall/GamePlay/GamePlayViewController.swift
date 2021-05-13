//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var playHistoryCollection: UICollectionView!
    @IBOutlet weak var pitchButton: UIButton!
    
    var socket : WebSocketTaskConnection?
    var game : Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket = WebSocketTaskConnection(url: SocketEndPoint.baseURL)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeUp)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popViewControllerOnScreenEdgeSwipe(_:)))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
        
        let leaveMessage = SocketMessage(type: SocketRequest.leave, gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: leaveMessage)
        let outMessage = SocketMessage(type: SocketRequest.out, gameId: game.gameId, teamId: game.homeTeam.teamId)
        socket?.send(with: outMessage)
        
        configureButton()
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.down :
                let gamePlayViewController = UIStoryboard(name: "DetailScore", bundle: nil).instantiateViewController(withIdentifier: "DetailView")
                gamePlayViewController.modalPresentationStyle = .pageSheet
                self.present(gamePlayViewController, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    
    @objc func popViewControllerOnScreenEdgeSwipe(_ recognizer:
                                                    UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began {
            let vc = UIStoryboard(name: "GameHistory", bundle: nil).instantiateViewController(withIdentifier: "GameHistory") as! GameHistoryViewController
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = vc
            present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func didTouchPitch(_ sender: UIButton) {
        guard let game = game else { return }
        //        manager?.didRequest(gameId: game.gameId, teamId: 0)
    }
}

extension GamePlayViewController : WebSocketConnectionDelegate{
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
        
    }
    func onMessage(connection: WebSocketConnection, string: String) {
        print(string)
    }
}

// MARK: - Configuration
extension GamePlayViewController {
    func configureButton() {
        pitchButton.layer.cornerRadius = 10
        pitchButton.layer.shadowColor = UIColor.gray.cgColor
        pitchButton.layer.shadowOpacity = 1.0
        pitchButton.layer.shadowOffset = CGSize.zero
        pitchButton.layer.shadowRadius = 6
    }
}
