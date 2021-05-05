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
    }
    func loadGame(){
        NetworkManager()
            .requestResource(gameURL: .game, decodeType: Game.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error) : print(error.message)
                case .finished : break
                }
            }, receiveValue: { [weak self] in
                self?.game = $0
                self?.homeTeam.setTitle(self?.game?.homeTeam.name, for: .normal)
                self?.awayTeam.setTitle(self?.game?.awayTeam.name, for: .normal)
            })
                    
        
    }
    @IBAction func didSelectHome(_ sender: UIButton) {
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
    }
}
