//
//  GroundView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GroundView: UIView {
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
    
        line.move(to: CGPoint(x: bounds.midX, y: bounds.minY + 40))
        line.addLine(to: CGPoint(x: bounds.maxX - 40, y: bounds.midY))
        line.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - 40))
        line.addLine(to: CGPoint(x: bounds.minX + 40, y: bounds.midY))
        UIColor.gray.setStroke()
        line.lineWidth = 5
        line.close()
        line.stroke()

        let threeBase = UIBezierPath()
        
        threeBase.move(to: CGPoint(x: bounds.minX + 40, y: bounds.midY - 40))
        threeBase.addLine(to: CGPoint(x: bounds.minX + 80, y: bounds.midY))
        threeBase.addLine(to: CGPoint(x: bounds.minX + 40, y: bounds.midY + 40))
        threeBase.addLine(to: CGPoint(x: bounds.minX, y: bounds.midY))
        UIColor.white.setStroke()
        UIColor.white.setFill()
        threeBase.fill()
        threeBase.close()
        threeBase.stroke()
        
        
        let twoBase = UIBezierPath()
        
        twoBase.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        twoBase.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.minY + 40))
        twoBase.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY + 80))
        twoBase.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.minY + 40))
        UIColor.white.setStroke()
        UIColor.white.setFill()
        twoBase.fill()
        twoBase.close()
        twoBase.stroke()
        
        let oneBase = UIBezierPath()
        
        oneBase.move(to: CGPoint(x: bounds.maxX - 40 , y: bounds.midY - 40))
        oneBase.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        oneBase.addLine(to: CGPoint(x: bounds.maxX - 40, y: bounds.midY + 40))
        oneBase.addLine(to: CGPoint(x: bounds.maxX - 80, y: bounds.midY))
        UIColor.white.setStroke()
        UIColor.white.setFill()
        oneBase.fill()
        oneBase.close()
        oneBase.stroke()
        
        
        let homeBase = UIBezierPath()
        homeBase.move(to: CGPoint(x: bounds.midX, y: bounds.maxY - 80))
        homeBase.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.maxY - 40))
        homeBase.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.maxY + 40))
        homeBase.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.maxY + 40))
        homeBase.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.maxY - 40))
        UIColor.white.setStroke()
        UIColor.white.setFill()
        homeBase.fill()
        homeBase.close()
        homeBase.stroke()

    }

}
