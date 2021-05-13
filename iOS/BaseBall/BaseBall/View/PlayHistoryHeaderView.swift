//
//  PlayHistoryHeaderView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class PlayHistoryHeaderView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var recordId: UILabel!
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var playerState: UILabel!
    
    func configure(id: Int?, name: String?, status: String?) {
        recordId.text = "\(id ?? 0)번"
        player.text = "타자 " + (name ?? "")
        playerState.text = status
    }
}
