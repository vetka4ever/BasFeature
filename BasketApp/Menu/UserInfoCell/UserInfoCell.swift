//
//  UserInfoCell.swift
//  BasketApp
//
//  Created by Daniil on 08.04.2021.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
