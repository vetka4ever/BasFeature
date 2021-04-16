//
//  StaticView.swift
//  BasketApp
//
//  Created by Daniil on 14.12.2020.
//

import UIKit
var currentStaticPlayer = "0"
var currentStaticZone = "0"
var arrayStatisticsButton = [UIButton]()

class StatisticsView: UIViewController {
    @IBAction func backToGame(_ sender: Any) {
        playerFlag = false
        let SB = UIStoryboard(name: "Main", bundle: nil)
        let VC = SB.instantiateViewController(identifier: "Field")
        VC.modalPresentationStyle = .fullScreen
        self.present(VC, animated: true, completion: nil)
    }
    @IBOutlet var playerScroll: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerScroll.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCell")
        self.playerScroll.dataSource = self
        self.playerScroll.delegate = self
        self.playerScroll.backgroundColor = . blue
        self.playerScroll.layer.cornerRadius = 20
       }
    
}
extension StatisticsView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return team.team.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        let currentPlayer = team.team[indexPath.item]
        cell.setUpCell(cell: currentPlayer)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
}
