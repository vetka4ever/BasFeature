//
//  namePlayerCell.swift
//  BasketApp
//
//  Created by Daniil on 03.02.2021.
//

import UIKit

class namePlayerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var namePlayer: UILabel!
    @IBOutlet var textField: UITextField!
    
}
