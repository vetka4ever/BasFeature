//
//  addCell.swift
//  BasketApp
//
//  Created by Daniil on 02.02.2021.
//

import UIKit

class addCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBOutlet var textFieldCell: UITextField!
    @IBOutlet var nameCell: UILabel!
    override func prepareForReuse() {
        super.prepareForReuse()
        nameCell.isHidden = false
        textFieldCell.isHidden = false
    }
}
    
