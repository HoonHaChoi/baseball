//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    @IBOutlet weak var playHistoryCollection: UICollectionView!
    @IBOutlet weak var groundView: GroundView!
    
    private let baseBallImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "baseball") ?? UIImage())
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var limitAreaRight = groundView.bounds.midX + 50
    private lazy var limitAreaLeft = groundView.bounds.midX - 100
    private lazy var limitAreaTop = groundView.bounds.midY - 100
    private lazy var limitAreaBottom = groundView.bounds.midY + 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeUp)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popViewControllerOnScreenEdgeSwipe(_:)))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
        
        groundView.addSubview(baseBallImageView)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag))
        baseBallImageView.addGestureRecognizer(panGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        makeBall()
    }
    
    private func makeBall() {
        baseBallImageView.frame = CGRect.moveBall(x: groundView.bounds.midX - 20,
                                                  y: groundView.bounds.midY - 20)
    }
    
    private func animateBaseBall() {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: [.repeat]) {
            self.baseBallImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        UIView.animate(withDuration: 1.5,
                       delay: 0.0) {
            self.baseBallImageView.frame = CGRect.moveBall(x: self.groundView.bounds.midX - 20,
                                                           y: self.groundView.bounds.maxY - 40)
            
        } completion: { _ in
            self.baseBallImageView.layer.removeAllAnimations()
            self.baseBallImageView.transform = .identity
        }
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
    
    @objc func drag(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        if gesture.state == .changed {
            gesture.view?.center = CGPoint(x: baseBallImageView.center.x + translation.x,
                                           y: baseBallImageView.center.y + translation.y)
            gesture.setTranslation(.zero, in: self.view)
        }
        
        if limitAreaRight <= self.baseBallImageView.frame.origin.x {
            baseBallImageView.frame = CGRect.movePlayer(x: limitAreaRight,
                                                        y: self.baseBallImageView.frame.origin.y)
        }
        
        if self.baseBallImageView.frame.origin.x <= limitAreaLeft  {
            baseBallImageView.frame = CGRect.movePlayer(x: limitAreaLeft,
                                                        y: self.baseBallImageView.frame.origin.y)
                                             
        }
        
        if self.baseBallImageView.frame.origin.y < limitAreaTop  {
            baseBallImageView.frame = CGRect.movePlayer(x: self.baseBallImageView.frame.origin.x,
                                                        y: limitAreaTop)
        }
        
        if self.baseBallImageView.frame.origin.y > limitAreaBottom {
            baseBallImageView.frame = CGRect.movePlayer(x: self.baseBallImageView.frame.origin.x,
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
}

