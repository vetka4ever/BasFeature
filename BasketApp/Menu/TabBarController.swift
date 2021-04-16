//
//  Menu2.swift
//  BasketApp
//
//  Created by Daniil on 06.03.2021.
//

import UIKit

class TabBarController: UITabBarController
{

    
  
    override func viewDidLoad() 
    {
        self.selectedIndex = 1
    }
   
//self.selectedIndex == 0)
//    {
//        let alert = UIAlertController(title: "Внимание", message: "Во время игры нельзя сменить выбранные команды.\nХотите продолжить?", preferredStyle: .actionSheet)
//        let ok = UIAlertAction(title: "Ok", style: .destructive) {(action) in
//            
//            if myTeamRead[0].myTeam == nil && enemysTeamRead[0].myTeam == nil
//            {
//                let alertMyTeamsEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команды", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .destructive) {(action) in
//                    self.selectedIndex = 1
//                    self.selectedViewController = self.viewControllers![1]
//                }
//                alertMyTeamsEmpty.addAction(ok)
//                self.present(alertMyTeamsEmpty, animated: true, completion: nil)
//            }
//            else if myTeamRead[0].myTeam == nil
//            {
//                let alertMyTeamEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команду", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
//                alertMyTeamEmpty.addAction(ok)
//                self.present(alertMyTeamEmpty, animated: true, completion: nil)
//            }
//            else if enemysTeamRead[0].myTeam == nil
//            {
//                let alertEnemyTeamEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команду противника", preferredStyle: .alert)
//                let ok = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
//                alertEnemyTeamEmpty.addAction(ok)
//                self.present(alertEnemyTeamEmpty, animated: true, completion: nil)
//            }
//            else
//            {
//                let newVC = self.storyboard?.instantiateViewController(identifier: "Field")
//                self.navigationController?.pushViewController(newVC!, animated: true)
//            }
//        }
//        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
//        alert.addAction(ok)
//        alert.addAction(no)
//        present(alert, animated: true, completion: nil)
//    
}
