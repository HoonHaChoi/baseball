//
//  GameCell.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/04.
//

import UIKit

class GameCell: UICollectionViewCell {
    
    @IBOutlet weak var frontView: UIStackView!
    @IBOutlet weak var backView: UIStackView!
    
    
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    
    var isFaceUp: Bool = true
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func flip(){
        if isFaceUp == true {
            UIView.transition(from: frontView,
                              to: backView,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
            self.contentView.backgroundColor = .white
        } else {
            UIView.transition(from: backView,
                              to: frontView,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion: nil)
        }
        isFaceUp = !isFaceUp
    }
}
