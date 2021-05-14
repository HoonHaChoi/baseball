//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit
import Combine
import AVFoundation

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var groundView: GroundView!
    
    var socket : WebSocketTaskConnection?
    
    var gameId : Int!
    var team : Team!
    
    private var gameStatusView: GameSBOStackView = {
        let stackView = GameSBOStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var gameBatterView: PlayerView = {
        let batterView = PlayerView()
        batterView.translatesAutoresizingMaskIntoConstraints = false
        return batterView
    }()
    
    private var gamePitcherView: PlayerView = {
        let PitcherView = PlayerView()
        PitcherView.translatesAutoresizingMaskIntoConstraints = false
        return PitcherView
    }()
    
    private lazy var edgePanGesture: UIScreenEdgePanGestureRecognizer = {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveGameHistoryView(_:)))
        edgePan.edges = .right
        return edgePan
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dragBall))
        return panGesture
    }()
    
    private let baseBallImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "baseball") ?? UIImage())
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let baseBallBatImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bat1") ?? UIImage())
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var limitAreaRight = groundView.bounds.midX + 50
    private lazy var limitAreaLeft = groundView.bounds.midX - 100
    private lazy var limitAreaTop = groundView.bounds.midY - 100
    private lazy var limitAreaBottom = groundView.bounds.midY + 10
    
    private var cancellable = Set<AnyCancellable>()
    
    private var recordOfPitching: [RecordOfPitching] = []
    private var first: Bool = false
    private var second: Bool = false
    private var thrid: Bool = false
    private var home: Bool = false
    
    private var pianoSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "BaseballBat", ofType: "mp3")!)
    private var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
        socket?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBall()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let leaveMessage = SocketMessage(type: SocketRequest.leave, gameId: gameId, teamId: team.teamId)
        socket?.send(with: leaveMessage)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let outMessage = SocketMessage(type: SocketRequest.out, gameId: gameId, teamId: team.teamId)
        socket?.send(with: outMessage)
        socket?.disConnect()
    }
    private func bind() {
        NetworkManager().requestResource(gameURL: .games, decodeType: GameInfo.self, at: 1)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            }
            receiveValue: { [weak self] (status) in
                self?.gameStatusView.configure(strike: status.statusBoard.strike,
                                               ball: status.statusBoard.ball,
                                               out: status.statusBoard.out)
                self?.updateView(status: status)
                self?.gameBatterView.configureBatter(by: status.statusBoard.batter)
                self?.gamePitcherView.configurePitcher(by: status.statusBoard.pitcher)
                self?.UpdateGroundBasePlayer(first: status.statusBoard.firstBase,
                                             second: status.statusBoard.secondBase,
                                             thrid: status.statusBoard.thirdBase,
                                             home: status.statusBoard.homeBase)
                self?.recordOfPitching = status.recordOfPitching
            }.store(in: &cancellable)
    }
    
    private func configure() {
        view.addSubview(gameStatusView)
        view.addSubview(gameBatterView)
        view.addSubview(gamePitcherView)
        view.addGestureRecognizer(edgePanGesture)
        groundView.addSubview(baseBallImageView)
        groundView.addSubview(baseBallBatImageView)
        
        gameStatusView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        gameStatusView.topAnchor.constraint(equalTo: homeTeamNameLabel.bottomAnchor, constant: 30).isActive = true
        
        gameBatterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        gameBatterView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        gameBatterView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        gamePitcherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -250).isActive = true
        gamePitcherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        gamePitcherView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        baseBallImageView.addGestureRecognizer(panGesture)
    }
    
    private func makeBall() {
        baseBallImageView.frame = CGRect.moveBall(x: groundView.bounds.midX - 20,
                                                  y: groundView.bounds.midY - 20)
        
        baseBallBatImageView.frame = CGRect(origin: CGPoint(x: groundView.bounds.midX - 40,
                                                            y: groundView.bounds.maxY - 60),size: CGSize(width: 25, height: 80))
        baseBallBatImageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
    
    private func animateBaseBall() {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.repeat]) {
            self.baseBallImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.55) {
            self.baseBallBatImageView.transform = CGAffineTransform(rotationAngle: 0)
        }
        UIView.animate(withDuration: 0.8,
                       delay: 0.0, options: [.curveEaseIn]) {
            self.baseBallImageView.frame = CGRect.moveBall(x: self.groundView.bounds.midX - 20,
                                                           y: self.groundView.bounds.maxY - 40)
        } completion: { [weak self] _ in
            self?.requestPitch()
            self?.bind()
        }
    }
    
    private func requestPitch() {
        NetworkManager().requestPitchResource(gameURL: .pitch, decodeType: Pitch.self, gameIndex: 1, teamIndex: 1)
            .receive(on: DispatchQueue.main)
            .sink { (_) in
            } receiveValue: { [weak self] (pitch) in
                pitch.result == "hit" ? self?.hitBaseBallAnimation() : self?.resetBaseBallLocation()
            }.store(in: &self.cancellable)
    }
    
    private func hitBaseBallAnimation() {
        audioPlayer = try! AVAudioPlayer(contentsOf: pianoSound as URL, fileTypeHint: nil)
               audioPlayer.prepareToPlay()
        audioPlayer.play()

        UIView.animate(withDuration: 0.5) {
            self.baseBallImageView.frame = CGRect.moveBall(x: self.groundView.bounds.minX + CGFloat(Int.random(in: 100...600)), y: CGFloat(Int.random(in: 0...400)))
        } completion: { (_) in
            self.resetBaseBallLocation()
        }
    }
    
    private func resetBaseBallLocation() {
        self.baseBallImageView.layer.removeAllAnimations()
        self.baseBallImageView.transform = .identity
        makeBall()
    }
    
    private func updateView(status: GameInfo) {
        self.homeTeamNameLabel.text = status.homeTeam.name
        self.homeTeamScoreLabel.text = String(status.homeTeam.score)
        self.awayTeamNameLabel.text = status.awayTeam.name
        self.awayTeamScoreLabel.text = String(status.awayTeam.score)
    }
    
    private func UpdateGroundBasePlayer(first: Bool,second: Bool,thrid: Bool,home: Bool) {
        if self.first != first || self.second != second || self.thrid != thrid || self.home != home {
            self.groundView.movePlayer(firstBase: first, secondBase: second, thridBase: thrid, homeBase: home)
            self.first = first
            self.second = second
            self.thrid = thrid
            self.home = home
        }
    }
    
    @objc func moveGameHistoryView(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began {
            guard let gameHistoryViewController = UIStoryboard(name: "GameHistory", bundle: nil).instantiateViewController(withIdentifier: "GameHistory") as? GameHistoryViewController else {
                return
            }
            gameHistoryViewController.recordOfPitching = recordOfPitching
            gameHistoryViewController.modalPresentationStyle = .custom
            gameHistoryViewController.transitioningDelegate = gameHistoryViewController
            present(gameHistoryViewController, animated: true, completion: nil)
        }
    }
    
    @objc func dragBall(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        if gesture.state == .changed {
            gesture.view?.center = CGPoint(x: baseBallImageView.center.x + translation.x,
                                           y: baseBallImageView.center.y + translation.y)
            gesture.setTranslation(.zero, in: self.view)
        }
        
        if limitAreaRight <= self.baseBallImageView.frame.origin.x {
            baseBallImageView.frame = CGRect.moveBall(x: limitAreaRight,
                                                      y: self.baseBallImageView.frame.origin.y)
        }
        
        if self.baseBallImageView.frame.origin.x <= limitAreaLeft  {
            baseBallImageView.frame = CGRect.moveBall(x: limitAreaLeft,
                                                      y: self.baseBallImageView.frame.origin.y)
        }
        
        if self.baseBallImageView.frame.origin.y < limitAreaTop  {
            baseBallImageView.frame = CGRect.moveBall(x: self.baseBallImageView.frame.origin.x,
                                                      y: limitAreaTop)
        }
        
        if self.baseBallImageView.frame.origin.y > limitAreaBottom {
            baseBallImageView.frame = CGRect.moveBall(x: self.baseBallImageView.frame.origin.x,
                                                      y: limitAreaBottom)
            gesture.isEnabled = false
            gesture.isEnabled = true
            self.animateBaseBall()
        }
    }
    
    @IBAction func updateView(_ sender: UIButton) {
        groundView.setNeedsDisplay()
        makeBall()
    }
    
    @IBAction func moveDetailScoreView(_ sender: Any) {
        let gamePlayViewController = UIStoryboard(name: "DetailScore", bundle: nil).instantiateViewController(withIdentifier: "DetailView")
        gamePlayViewController.modalPresentationStyle = .pageSheet
        self.present(gamePlayViewController, animated: true, completion: nil)
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
        let result = ResultOfPitch.init(rawValue: string)
        
        switch result {
        case .ball: gameStatusView.addBall(ball: 1)
        case .strike: gameStatusView.addStrike(strike: 1)
        case .hit: break
        default : break
        }
    }
}
