//
//  PlayerCell.swift
//  BasketApp
//
//  Created by Daniil on 10.02.2021.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 25
    }
    @IBOutlet var playerNum: UILabel!
    
}
