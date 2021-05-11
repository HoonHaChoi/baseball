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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    @IBAction func didSelectHome(_ sender: UIButton) {
        let gameMatchingViewController = self.storyboard?.instantiateViewController(identifier: "GameMatching")as! MatchingViewController
        gameMatchingViewController.transitioningDelegate = self
        gameMatchingViewController.game = game
        self.present(gameMatchingViewController, animated: true, completion: nil)
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
        
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
