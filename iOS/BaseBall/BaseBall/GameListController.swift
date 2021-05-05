//
//  ViewController.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import UIKit
import Combine

class GameListController: UIViewController {
    
    @IBOutlet weak var gameList: UICollectionView!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfiure()
        registerNIB()
        gameList.delegate = self
        gameList.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registerNIB() {
        let nibName = UINib(nibName: "GameCell", bundle: nil)
        gameList.register(nibName, forCellWithReuseIdentifier: "GameCell")
        gameList.register(nibName, forCellWithReuseIdentifier: "GameOptionCell")
    }
}

extension GameListController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = (storyboard?.instantiateViewController(identifier: "GameOptionController"))! as GameOptionController
        viewController.loadGame()
        present(viewController, animated: true, completion: nil)
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
    func collectionViewConfiure() {
        gameList.translatesAutoresizingMaskIntoConstraints = false
        gameList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        gameList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 80).isActive = true
        gameList.widthAnchor.constraint(equalToConstant: 600).isActive = true
        gameList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: gameList.frame.width / 1.3, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
