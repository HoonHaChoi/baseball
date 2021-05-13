//
//  GroundView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GroundView: UIView {

    @IBOutlet weak var playerStack: UIStackView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var oneplayer = UIImageView(image: UIImage(named: "hitter") ?? UIImage())
    var twoplayer = UIImageView(image: UIImage(named: "hitter") ?? UIImage())
    var threeplayer = UIImageView(image: UIImage(named: "hitter") ?? UIImage())
    var homeplayer = UIImageView(image: UIImage(named: "hitter") ?? UIImage())
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
    
        line.move(to: CGPoint(x: bounds.midX, y: bounds.minY + 40))
        line.addLine(to: CGPoint(x: bounds.maxX - 40, y: bounds.midY))
        line.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - 40))
        line.addLine(to: CGPoint(x: bounds.minX + 40, y: bounds.midY))
        UIColor.white.setStroke()
        UIColor.systemGreen.setFill()
        line.lineWidth = 5
        line.fill()
        line.close()
        line.stroke()
        
        let base = UIBezierPath()
        base.move(to: CGPoint(x: bounds.minX + 40, y: bounds.midY - 40))
        base.addLine(to: CGPoint(x: bounds.minX + 80, y: bounds.midY))
        base.addLine(to: CGPoint(x: bounds.minX + 40, y: bounds.midY + 40))
        base.addLine(to: CGPoint(x: bounds.minX, y: bounds.midY))
        base.addLine(to: CGPoint(x: bounds.minX + 40, y: bounds.midY - 40))
        base.lineCapStyle = .round
        base.lineJoinStyle = .round
        UIColor.brown.setStroke()
        UIColor.brown.setFill()
        base.lineWidth = 3
        base.stroke()
        base.close()
        
        base.move(to: CGPoint(x: bounds.midX, y: bounds.minY))
        base.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.minY + 40))
        base.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY + 80))
        base.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.minY + 40))
        base.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY))
        base.lineWidth = 3
        base.stroke()
        base.fill()
        base.close()
    
        base.move(to: CGPoint(x: bounds.maxX - 40 , y: bounds.midY - 40))
        base.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        base.addLine(to: CGPoint(x: bounds.maxX - 40, y: bounds.midY + 40))
        base.addLine(to: CGPoint(x: bounds.maxX - 80, y: bounds.midY))
        base.fill()
        base.close()

        base.move(to: CGPoint(x: bounds.midX, y: bounds.maxY - 80))
        base.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.maxY - 40))
        base.addLine(to: CGPoint(x: bounds.midX + 40, y: bounds.maxY + 40))
        base.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.maxY + 40))
        base.addLine(to: CGPoint(x: bounds.midX - 40, y: bounds.maxY - 40))
        base.fill()
        base.close()
        
    }
    
    func movePlayer(firstBase: Bool, secondBase: Bool, thridBase: Bool, homeBase: Bool) {
        firstBase ? basefitst() : hidePlayer(image: oneplayer)
        secondBase ? baseSecond() : hidePlayer(image: twoplayer)
        thridBase ? basethrid() : hidePlayer(image: threeplayer)
        homeBase ? basehome() : hidePlayer(image: homeplayer)
    }
    
    func basefitst() {
        oneplayer.frame = CGRect.movePlayer(x: self.bounds.midX,
                                            y: self.bounds.maxY - 40)
        UIView.animate(withDuration: 2.0) {
            self.oneplayer.frame = CGRect.movePlayer(x: self.bounds.maxX - 60,
                                                     y: self.bounds.midY - 20)
        }
    }
    
    func baseSecond() {
        twoplayer.frame = CGRect.movePlayer(x: self.bounds.maxX - 60, y: self.bounds.midY - 20)
        UIView.animate(withDuration: 2.0) {
            self.twoplayer.frame = CGRect.movePlayer(x: self.bounds.midX - 20,
                                                     y: self.bounds.minY + 20)
        }
    }
    
    func basethrid() {
        threeplayer.frame = CGRect.movePlayer(x: self.bounds.midX - 20,
                                              y: self.bounds.minY + 20)
        UIView.animate(withDuration: 2.0) {
            self.threeplayer.frame = CGRect.movePlayer(x: self.bounds.minX + 20,
                                                       y: self.bounds.midY - 20)
        }
    }
    
    func basehome() {
        homeplayer.isHidden = false
        homeplayer.frame = CGRect.movePlayer(x: self.bounds.minX + 20,
                                             y: self.bounds.midY - 20)
        UIView.animate(withDuration: 2.0) {
            self.homeplayer.frame = CGRect.movePlayer(x: self.bounds.midX - 20,
                                                      y: self.bounds.maxY - 40)
        } completion: { _ in
            self.homeplayer.isHidden = true
        }
    }
    
    func hidePlayer<T: UIView>(image: T) {
        image.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(oneplayer)
        addSubview(twoplayer)
        addSubview(threeplayer)
        addSubview(homeplayer)
        
        hidePlayer(image: oneplayer)
        hidePlayer(image: twoplayer)
        hidePlayer(image: threeplayer)
        hidePlayer(image: homeplayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(oneplayer)
        addSubview(twoplayer)
        addSubview(threeplayer)
        addSubview(homeplayer)
        
        hidePlayer(image: oneplayer)
        hidePlayer(image: twoplayer)
        hidePlayer(image: threeplayer)
        hidePlayer(image: homeplayer)
    }
}
