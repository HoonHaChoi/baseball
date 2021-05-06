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
        moveGamePlayView()
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
        moveGamePlayView()
    }
    
    private func moveGamePlayView() {
        let gamePlayViewController = UIStoryboard(name: "GamePlay", bundle: nil).instantiateViewController(withIdentifier: "GamePlay")
        gamePlayViewController.modalPresentationStyle = .overFullScreen
        self.present(gamePlayViewController, animated: true, completion: nil)
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
