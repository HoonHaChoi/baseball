//
//  PlayerHistoryCell.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class PlayerHistoryCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
    
}
