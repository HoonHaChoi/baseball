//
//  ViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import UIKit

class GameListController: UIViewController {

    @IBOutlet weak var gameList: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNIB()
        gameList.delegate = self
        gameList.dataSource = self
    }
    
    func registerNIB() {
        let nibName = UINib(nibName: "GameCell", bundle: nil)
        gameList.register(nibName, forCellWithReuseIdentifier: "GameCell")
        gameList.register(nibName, forCellWithReuseIdentifier: "GameOptionCell")
    }
}

extension GameListController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GameCell
        cell.flip()
    }
}

extension GameListController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gameList.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath)
        cell.layer.cornerRadius = 10
        return cell
    }
}
extension GameListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameList.frame.width / 1.3, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
