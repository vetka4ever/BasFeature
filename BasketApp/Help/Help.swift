//
//  Help.swift
//  BasketApp
//
//  Created by Daniil on 19.04.2021.
//

import UIKit

class Help: UIViewController {

    @IBOutlet var tableView: UICollectionView!
    let cellId = "Help"
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "HelpCell", bundle: nil), forCellWithReuseIdentifier: cellId)
      
    }
    

    

}
extension Help: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tableView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HelpCell
        cell.helpImage.image = UIImage(named: "Help\(indexPath.row + 1)")
        cell.helpImage.contentMode = .center
        return cell
    }
    
   
    
    
}

