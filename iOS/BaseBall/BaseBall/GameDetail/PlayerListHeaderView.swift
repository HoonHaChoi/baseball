//
//  PlayerListHeaderView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/08.
//

import UIKit

class PlayerListHeaderView: UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    
    static let nib: UINib = UINib(nibName: identifier, bundle: nil)
}
