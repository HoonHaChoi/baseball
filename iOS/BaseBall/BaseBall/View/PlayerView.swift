//
//  PlayerView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/13.
//

import UIKit

class PlayerView: UIView {
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerFirstRecord: UILabel!
    @IBOutlet weak var playerSecondRecord: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: PlayerView.self)
        let view = bundle.loadNibNamed("PlayerView", owner: self, options: nil)?.first as! UIView
        addSubview(view)
    }
    
    func configureBatter(by player: Batter) {
        playerNameLabel.text = "타자 " + player.name
        playerFirstRecord.text = "\(player.numOfBatting) 타석"
        playerSecondRecord.text = "\(player.numOfHitting) 안타"
    }
    
    func configurePitcher(by player: Pitcher) {
        playerNameLabel.text = "투수 " + player.name
        playerFirstRecord.text = "#\(player.numOfThrowing)"
        
    }
}
