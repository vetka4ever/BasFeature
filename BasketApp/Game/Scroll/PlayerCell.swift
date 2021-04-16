//
//  PlayerCell.swift
//  BasketApp
//
//  Created by Daniil on 11.12.2020.
//

import UIKit

class PlayerCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
            
        
        setUpCell()
    }
    func setUpCell () {
        CellOutlet.setTitle(String(23), for: UIControl.State.normal)
    }
    @IBOutlet var CellOutlet: UIButton!
    @IBAction func CellAction(_ sender: Any) {
    
    }
    
}
