//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit
import Combine

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var groundView: GroundView!
    
    private var gameStatusView: GameSBOStackView = {
        let stackView = GameSBOStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBall()
    }
    
    private func bind() {
        NetworkManager().requestResource(gameURL: .games, decodeType: GameInfo.self, at: 1)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            }
            receiveValue: { (info) in
                self.gameStatusView.configure(strike: 1, ball: 2, out: 3)
            }.store(in: &cancellable)
    }
    
    
    private func configure() {
        view.addSubview(gameStatusView)
        view.addGestureRecognizer(edgePanGesture)
        groundView.addSubview(baseBallImageView)
        groundView.addSubview(baseBallBatImageView)

        gameStatusView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        gameStatusView.topAnchor.constraint(equalTo: homeTeamNameLabel.bottomAnchor, constant: 30).isActive = true
        
        baseBallImageView.addGestureRecognizer(panGesture)
    }
    
    private func makeBall() {
        baseBallImageView.frame = CGRect.moveBall(x: groundView.bounds.midX - 20,
                                                  y: groundView.bounds.midY - 20)
        
        baseBallBatImageView.frame = CGRect(origin: CGPoint(x: groundView.bounds.midX - 60,
                                                            y: groundView.bounds.maxY - 60),size: CGSize(width: 35, height: 90))
        baseBallBatImageView.transform = CGAffineTransform(rotationAngle: .pi / 2)
    }
    
    private func animateBaseBall() {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.repeat]) {
            self.baseBallImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.8) {
            self.baseBallBatImageView.transform = CGAffineTransform(rotationAngle: 0)
        }
        UIView.animate(withDuration: 0.8,
                       delay: 0.0, options: [.curveEaseIn]) {
            self.baseBallImageView.frame = CGRect.moveBall(x: self.groundView.bounds.midX - 20,
                                                           y: self.groundView.bounds.maxY - 40)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.baseBallImageView.frame = CGRect.moveBall(x: self.groundView.bounds.midX + CGFloat(Int.random(in: 0...600)), y: CGFloat(Int.random(in: 0...400)))
            } completion: { (_) in
                self.baseBallImageView.layer.removeAllAnimations()
                self.baseBallImageView.transform = .identity
            }
            
        }
    }
    
    @objc func moveGameHistoryView(_ recognizer:
                                                    UIScreenEdgePanGestureRecognizer) {
        if recognizer.state == .began {
            guard let gameHistoryViewController = UIStoryboard(name: "GameHistory", bundle: nil).instantiateViewController(withIdentifier: "GameHistory") as? GameHistoryViewController else {
                return
            }
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

