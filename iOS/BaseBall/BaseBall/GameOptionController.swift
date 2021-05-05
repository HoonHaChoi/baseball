//
//  GameOptionViewController.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/04.
//

import UIKit
import Combine

class GameOptionController: UIViewController {
    
    @IBOutlet weak var homeTeam: UIButton!
    @IBOutlet weak var awayTeam: UIButton!
    
    var game: Game?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTeam.setTitle(game?.homeTeam.name, for: .normal)
        awayTeam.setTitle(game?.awayTeam.name, for: .normal)
        
        if game?.homeTeam.occupied == true {
            homeTeam.isEnabled = false
        }
        if game?.awayTeam.occupied == true {
            homeTeam.isEnabled = false
        }
    }
    @IBAction func didSelectHome(_ sender: UIButton) {
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
    }
}
