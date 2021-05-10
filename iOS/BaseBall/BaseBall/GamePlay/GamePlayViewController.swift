//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet weak var playHistoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
           swipeUp.direction = UISwipeGestureRecognizer.Direction.down
           view.addGestureRecognizer(swipeUp)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popViewControllerOnScreenEdgeSwipe(_:)))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
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
}

