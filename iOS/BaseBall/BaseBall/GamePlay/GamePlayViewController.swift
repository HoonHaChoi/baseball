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
    
    var manager : PitchSocketManager?
    var game : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = PitchSocketManager(self)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
           swipeUp.direction = UISwipeGestureRecognizer.Direction.down
           view.addGestureRecognizer(swipeUp)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popViewControllerOnScreenEdgeSwipe(_:)))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
        
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
        manager?.didRequest(gameId: game.gameId, teamId: 0)
    }
}

extension GamePlayViewController : SocketManagerDelegate{
    
    func didconnect() {
        print("connected")
    }
    func didReceive(with data: Any) {
        guard let data = data as? Pitch else {
            return
        }
        print(data.result)
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
