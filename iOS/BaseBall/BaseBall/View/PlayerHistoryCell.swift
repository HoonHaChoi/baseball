//
//  PlayerHistoryCell.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class PlayerHistoryCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UIButton!
    
    @IBOutlet weak var PitchingResultLabel: UILabel!
    @IBOutlet weak var numOfStrike: UILabel!
    @IBOutlet weak var numOfBall: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    func configure(number: Int,pitching: String, strike: Int, ball: Int) {
        numberLabel.setTitle("\(number)", for: .normal)
        PitchingResultLabel.text = convertResultText(result: pitching)
        numOfStrike.text = "\(strike)"
        numOfBall.text = "\(ball)"
    }
    
    private func convertResultText(result: String) -> String {
        result == "s" ? "스트라이크" : "볼"
     }
}
