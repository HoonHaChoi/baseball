//
//  GameHistoryViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/10.
//

import UIKit

class GameHistoryViewController: UIViewController {
    
    let menuWidth = UIScreen.main.bounds.width * 0.3
    var isPresenting = false
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var playHistoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        playHistoryCollection.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GameHistoryViewController.handleTap(_:)))
        
        view.addGestureRecognizer(tapGesture)

        playHistoryCollection.dataSource = self
        playHistoryCollection.delegate = self
        playHistoryCollection.register(PlayerHistoryCell.nib, forCellWithReuseIdentifier: PlayerHistoryCell.identifier)
        playHistoryCollection.register(PlayHistoryHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlayHistoryHeaderView.identifier)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension GameHistoryViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting

        if isPresenting == true {
            containerView.addSubview(toVC.view)
            playHistoryCollection.frame.origin.x += menuWidth
            backView.alpha = 0

            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.playHistoryCollection.frame.origin.x -= self.menuWidth
                self.backView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.playHistoryCollection.frame.origin.x += self.menuWidth
                self.backView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

extension GameHistoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerHistoryCell.identifier, for: indexPath) as? PlayerHistoryCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlayHistoryHeaderView.identifier, for: indexPath) as? PlayHistoryHeaderView else {
            return UICollectionReusableView()
        }
        return headerView
    }
    
}

extension GameHistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
