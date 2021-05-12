//
//  GameSBOStackView.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/12.
//

import UIKit

class GameSBOStackView: UIView {
    @IBOutlet weak var strikeStack: UIStackView!
    @IBOutlet weak var ballStack: UIStackView!
    @IBOutlet weak var outStack: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: GameSBOStackView.self)
        let view = bundle.loadNibNamed("GameSBOStackView", owner: self, options: nil)?.first as! UIView
        addSubview(view)
    }
    
    func configure(strike: Int, ball: Int, out: Int) {
        addStrike(strike: strike)
        addBall(ball: ball)
        addOut(out: out)
    }
    
    private func addStrike(strike: Int) {
        (0..<strike).forEach { _ in
            strikeStack.addArrangedSubview(makeCircleImageView(color: .yellow))
        }
    }
    
    private func addBall(ball: Int) {
        (0..<ball).forEach { _ in
            ballStack.addArrangedSubview(makeCircleImageView(color: .systemGreen))
        }
    }
    
    private func addOut(out: Int) {
        (0..<out).forEach { _ in
            outStack.addArrangedSubview(makeCircleImageView(color: .red))
        }
    }
    
    private func makeCircleImageView(color: UIColor) -> UIImageView {
        let circleImageView = UIImageView(image: UIImage(systemName: "circle.fill") ?? UIImage())
        circleImageView.contentMode = .scaleAspectFit
        circleImageView.tintColor = color
        return circleImageView
    }
    
}

