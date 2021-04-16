//
//  PlayerCell.swift
//  BasketApp
//
//  Created by Daniil on 13.12.2020.
//

import UIKit
var playerFlag = false
var arrayScrollButtons = [UIButton]()

class PlayerCell: UICollectionViewCell
{
    
    @IBOutlet var ButtonOutlet: UIButton!
    @IBAction func ButtonAction(_ sender: Any)
    {
        if (!playerFlag)
        {
            for item in arrayScrollButtons
            {
                item.backgroundColor = .orange
            }
            ButtonOutlet.backgroundColor = .red
            currentPlayer = ButtonOutlet.currentTitle!
            print(currentPlayer)

            playerFlag = true
        }
        else
        {
            if (ButtonOutlet.backgroundColor == .red)
            {
                
                ButtonOutlet.backgroundColor = .orange
                playerFlag = false
                currentPlayer = "Player"
                print(currentPlayer)
            }
            else
            {
                for item in arrayScrollButtons
                {
                    item.backgroundColor = .orange
                }
                self.ButtonOutlet.backgroundColor = .red
                currentPlayer = ButtonOutlet.currentTitle!
                print(currentPlayer)
                
            }
        }
        
    }
    
    func setUpCell(cell: Player)
    {
        self.ButtonOutlet.setTitle(String(cell.numeric), for: UIControl.State.normal)
        self.ButtonOutlet.setTitleColor(.black, for: UIControl.State.normal)
        self.ButtonOutlet.backgroundColor = .orange
        self.ButtonOutlet.layer.cornerRadius = 20
        if (arrayScrollButtons.count <= 7)
        {
            arrayScrollButtons.append(self.ButtonOutlet)
        }
    }
}


