//
//  GamePlayViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/06.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet weak var playHistoryCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playHistoryCollection.dataSource = self
        playHistoryCollection.delegate = self
        playHistoryCollection.register(PlayerHistoryCell.nib, forCellWithReuseIdentifier: PlayerHistoryCell.identifier)
        playHistoryCollection.register(PlayHistoryHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlayHistoryHeaderView.identifier)
        
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
           swipeUp.direction = UISwipeGestureRecognizer.Direction.down
           self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
         if let swipeGesture = gesture as? UISwipeGestureRecognizer{
             switch swipeGesture.direction {
                 case UISwipeGestureRecognizer.Direction.down :
                    let gamePlayViewController = UIViewController()
                    gamePlayViewController.modalPresentationStyle = .automatic
                    gamePlayViewController.view.backgroundColor = .white
                    self.present(gamePlayViewController, animated: true, completion: nil)
                 default:
                     break
             }
         }
     }
}

extension GamePlayViewController: UICollectionViewDataSource {
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

extension GamePlayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
}
