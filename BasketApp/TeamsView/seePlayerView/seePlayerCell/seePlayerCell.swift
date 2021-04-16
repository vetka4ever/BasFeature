//
//  seePlayerCell.swift
//  BasketApp
//
//  Created by Daniil on 09.02.2021.
//

import UIKit

class seePlayerCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet var textField: UITextField!
    @IBOutlet var playerTitle: UILabel!
    
    
}
