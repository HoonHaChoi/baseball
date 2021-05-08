//
//  DetailPlayerViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/08.
//

import UIKit

class DetailPlayerViewController: UIViewController {

    @IBOutlet weak var homePlayerCollectionView: UICollectionView!
    @IBOutlet weak var awayPlayerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePlayerCollectionView.register(PlayerScoreCell.nib, forCellWithReuseIdentifier: PlayerScoreCell.identifier)
        homePlayerCollectionView.register(PlayerListHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlayerListHeaderView.identifier)
        awayPlayerCollectionView.register(PlayerScoreCell.nib, forCellWithReuseIdentifier: PlayerScoreCell.identifier)
        awayPlayerCollectionView.register(PlayerListHeaderView.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlayerListHeaderView.identifier)
        
        homePlayerCollectionView.dataSource = self
        homePlayerCollectionView.delegate = self
        awayPlayerCollectionView.dataSource = self
        awayPlayerCollectionView.delegate = self
    }
}

extension DetailPlayerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerScoreCell.identifier, for: indexPath) as? PlayerScoreCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlayerListHeaderView.identifier, for: indexPath) as? PlayerListHeaderView else {
            return UICollectionReusableView()
        }
        return headerView
    }
}

extension DetailPlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
