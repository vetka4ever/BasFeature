//
//  StatisticViewViewController.swift
//  BasketApp
//
//  Created by Daniil on 12.03.2021.
//

import UIKit

class StatisticViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func deleteAllStat(_ sender: Any)
    {
        let alert = UIAlertController(title: "Внимание", message: "Все команды будут удалены.\nХотите продолжить?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Да", style: .destructive)
        {
            (action) in
            try! statWrite.write
            {
                statWrite.delete(statRead)
            }
            self.tableView.reloadData()
        }
        let no = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
extension StatisticViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (statRead.count == 0)
        {
            return 1
        }
        else
        {
            return  statRead.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        if (statRead.count > 0)
        {
            let cellName = String(statRead[statRead.count - indexPath.row - 1].stat!.currentDate)
                + " : " + String (statRead[statRead.count - indexPath.row - 1].stat!.myTeam.name) +
                " - " + String(statRead[statRead.count - indexPath.row - 1].stat!.enemyTeam.name)
            cell.textLabel?.text = cellName
        }
        else
        {
            cell.textLabel?.text = "Тут пусто🥺"
            cell.textLabel?.textAlignment = .center
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Прошедшие игры"
        
        return title
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "StaticViewGames") as! StaticViewGames
        vc.id = statRead.count - indexPath.row - 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (statRead.count > 0)
        {
            let swipeDelete = UIContextualAction(style: .destructive, title: "Удалить")
            {
                (action, view, success) in
                let alert = UIAlertController(title: "Внимание", message: "Вы уверены, что хотите удалить статистику данного матча?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Да", style: .destructive) {
                    (aciton) in
                    try! statWrite.write
                    {
                        statWrite.delete(statRead[statRead.count - 1 - indexPath.row])
                    }
                    tableView.reloadData()
                }
                let no = UIAlertAction(title: "Нет", style: .default, handler: nil)
                alert.addAction(ok)
                alert.addAction(no)
                self.present(alert, animated: true, completion: nil)
            }
            let swipe = UISwipeActionsConfiguration(actions: [swipeDelete])
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }
        else
        {
            return nil
        }
    }
}
