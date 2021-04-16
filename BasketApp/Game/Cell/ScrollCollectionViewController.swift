//
//  ScrollCollectionViewController.swift
//  BasketApp
//
//  Created by Daniil on 10.12.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class ScrollCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    }
}
