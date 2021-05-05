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
    
    @Published var game: Game?
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func loadGame(with id : Int){
        NetworkManager()
            .requestResource(gameURL: .games, decodeType: Game.self, at: id)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error) : print(error.message)
                case .finished :
                    DispatchQueue.main.async {
                        self?.homeTeam.setTitle(self?.game?.homeTeam.name, for: .normal)
                        self?.awayTeam.setTitle(self?.game?.awayTeam.name, for: .normal)
                    }
                }
            }, receiveValue: { [weak self] in
                self?.game = $0
            }).store(in: &cancellables)
    }
    @IBAction func didSelectHome(_ sender: UIButton) {
    }
    
    @IBAction func didSelectAway(_ sender: UIButton) {
    }
}
