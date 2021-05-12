//
//  CGRect+Extension.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/12.
//

import UIKit

extension CGRect {
    
    static func movePlayer(x: CGFloat, y: CGFloat) -> CGRect {
        self.init(origin: CGPoint(x: x, y: y), size: CGSize(width: 40, height: 40))
    }

    static func moveBall(x: CGFloat, y: CGFloat) -> CGRect {
        self.init(origin: CGPoint(x: x, y: y), size: CGSize(width: 50, height: 50))
    }
}

