//
//  UILabel+Flash.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import UIKit

extension UILabel {
    func startFlashing(interval : TimeInterval ) {
        self.alpha = 0.0;
        
        UIView.animate(withDuration: interval, //Time duration you want,
            delay: 0.0,
            options: [.curveEaseInOut, .autoreverse, .repeat],
            animations: { [weak self] in self?.alpha = 1.0 },
            completion: { [weak self] _ in self?.alpha = 0.0 })
    }
}
