//
//  MatchingTransitioner.swift
//  BaseBall
//
//  Created by 박혜원 on 2021/05/10.
//

import UIKit

class MatchingTransitioner: NSObject {
    private let animationDuration : Double
    private let animationType : AnimationType
    
    private let height : CGFloat = 260
    
    enum AnimationType {
        case present
        case dismiss
    }
    
    // MARK: - Init
    init(duration: Double, animationType : AnimationType){
        self.animationDuration = duration
        self.animationType = animationType
    }
}

extension MatchingTransitioner : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        switch animationType {
        case .present:
            transitionContext.containerView.addSubview(toViewController.view)
            presentAnimation(with: transitionContext, viewToAnimate: toViewController.view)
        case .dismiss:
            break
        }
    }
    func presentAnimation(with transitionContext : UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: {
                        viewToAnimate.clipsToBounds = true
                        viewToAnimate.frame = CGRect(x: 0,
                                                     y: viewToAnimate.bounds.midY - self.height/2,
                                                     width: viewToAnimate.bounds.width,
                                                     height: self.height)
                        viewToAnimate.backgroundColor = .clear
                       }){ _ in
            transitionContext.completeTransition(true)
        }
    }
}
