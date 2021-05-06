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
    
    @IBOutlet weak var frontView: UIStackView!
    @IBOutlet weak var backView: UIStackView!
    
    
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
