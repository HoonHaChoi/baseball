//
//  GameCell.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/04.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
        
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func configure(game: Game) {
        self.homeTeam.text = game.homeTeam.name
        self.awayTeam.text = game.awayTeam.name
    }
}
