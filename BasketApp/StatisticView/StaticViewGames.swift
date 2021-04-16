//
//  StaticViewGames.swift
//  BasketApp
//
//  Created by Daniil on 14.03.2021.
//

import UIKit

class StaticViewGames: UIViewController {
    var myTeamId = "myTeam"
    var enemyTeamId = "enemyTeam"
    var numTimeZoneId = "numTime"
    var currentTeam = Comand()
    var currentTimeZone = "Field"
    var currentPlayerInMyTeam = IndexPath()
    var currentPlayerInEnemyTeam = IndexPath()
    var id = 0;
    
    
    override func viewDidLoad() {
        myTeamColView.dataSource = self
        myTeamColView.delegate = self
        myTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: myTeamId)
        myTeamColView.backgroundColor = .blue
        myTeamColView.layer.cornerRadius = 25
        
        enemyTeamColView.dataSource = self
        enemyTeamColView.delegate = self
        enemyTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: enemyTeamId)
        enemyTeamColView.backgroundColor = .blue
        enemyTeamColView.layer.cornerRadius = 25
        
        numTimeZone.dataSource = self
        numTimeZone.delegate = self
        numTimeZone.register(UINib(nibName: "numTimeZoneCell", bundle: nil), forCellWithReuseIdentifier: numTimeZoneId)
        numTimeZone.backgroundColor = .blue
        numTimeZone.layer.cornerRadius = 20
        
        labels = [firstZoneLabel, secondZoneLabel, thirdZoneLabel, fourthZoneLabel, fifthZoneLabel, sixthZoneLabel, seventhZoneLabel, eightthZoneLabel, ninethZoneLabel, tenthZoneLabel, eleventhZoneLabel, twelvethZoneLabel, threteenthZoneLabel, fourteenthZoneLabel]
        
        for item in labels
        {
            item.isHidden = true
        }
        myTeamButtonOutlet.setTitle( statRead[id].stat?.myTeam.name, for: .normal)
        myTeamButtonOutlet.backgroundColor = .orange
        myTeamButtonOutlet.layer.cornerRadius = myTeamButtonOutlet.frame.height / 2
        enemyTeamButtonOutlet.setTitle(statRead[id].stat?.enemyTeam.name, for: .normal)
        enemyTeamButtonOutlet
            .backgroundColor = .orange
        enemyTeamButtonOutlet.layer.cornerRadius = enemyTeamButtonOutlet.frame.height / 2
        
    }
    @IBOutlet var myTeamButtonOutlet: UIButton!
    @IBOutlet var enemyTeamButtonOutlet: UIButton!
    @IBOutlet var numTimeZone: UICollectionView!
    @IBOutlet var fieldView: UIView!
    @IBOutlet var fieldImage: UIImageView!
    @IBOutlet var myTeamColView: UICollectionView!
    @IBOutlet var enemyTeamColView: UICollectionView!
    @IBOutlet var firstZoneLabel: UILabel!
    @IBOutlet var secondZoneLabel: UILabel!
    @IBOutlet var thirdZoneLabel: UILabel!
    @IBOutlet var fourthZoneLabel: UILabel!
    @IBOutlet var fifthZoneLabel: UILabel!
    @IBOutlet var sixthZoneLabel: UILabel!
    @IBOutlet var seventhZoneLabel: UILabel!
    @IBOutlet var eightthZoneLabel: UILabel!
    @IBOutlet var ninethZoneLabel: UILabel!
    @IBOutlet var tenthZoneLabel: UILabel!
    @IBOutlet var eleventhZoneLabel: UILabel!
    @IBOutlet var twelvethZoneLabel: UILabel!
    @IBOutlet var threteenthZoneLabel: UILabel!
    @IBOutlet var fourteenthZoneLabel: UILabel!
    var labels  = [UILabel]()
    
    @IBAction func myTeamButton(_ sender: Any)
    {
        currentTeam = statRead[id].stat!.myTeam
        if (currentTimeZone == "Field")
        {
            //            let alert = UIAlertController(title:" Внимание", message: "Вы не выбрали тайм🙀", preferredStyle: .alert)
            //            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            //            alert.addAction(ok)
            //            self.present(alert, animated: true, completion: nil)
            let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.myTeam.players, oneTime: false)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            myTeamButtonOutlet.backgroundColor = .red
            enemyTeamButtonOutlet.backgroundColor = .orange
        }
        else
        {
            let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.myTeam.players, oneTime: true)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            myTeamButtonOutlet.backgroundColor = .red
            enemyTeamButtonOutlet.backgroundColor = .orange
            
        }
        
    }
    
    @IBAction func enemyTeamButton(_ sender: Any)
    {
        currentTeam = statRead[id].stat!.enemyTeam
        if (currentTimeZone == "Field")
        {
            //            let alert = UIAlertController(title:" Внимание", message: "Вы не выбрали тайм🙀", preferredStyle: .alert)
            //            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            //            alert.addAction(ok)
            //            self.present(alert, animated: true, completion: nil)
            let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.enemyTeam.players, oneTime: false)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            myTeamButtonOutlet.backgroundColor = .orange
            enemyTeamButtonOutlet.backgroundColor = .red
        }
        else
        {
            let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.enemyTeam.players, oneTime: true)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            myTeamButtonOutlet.backgroundColor = .orange
            enemyTeamButtonOutlet.backgroundColor = .red
        }
    }
    
    
}
extension StaticViewGames: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == numTimeZone)
        {
            return 4
        }
        else
        {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == numTimeZone)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: numTimeZoneId, for: indexPath) as! numTimeZoneCell
            cell.title.text = String(indexPath.row + 1)
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 15
            return cell
        }
        if (collectionView == myTeamColView)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myTeamId, for: indexPath) as! PlayerCell
            cell.playerNum.text = statRead[id].stat?.myTeam.players[indexPath.row].numeric
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 25
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: enemyTeamId, for: indexPath) as! PlayerCell
            cell.playerNum.text = statRead[id].stat?.enemyTeam.players[indexPath.row].numeric
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 25
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == numTimeZone)
        {
            let cell = collectionView.cellForItem(at: indexPath)
            if (cell?.backgroundColor == .red)
            {
                cell?.backgroundColor = .orange
                currentTimeZone = "Field"
                
                for item in labels
                {
                    item.isHidden = true
                }
                if (currentPlayerInMyTeam != IndexPath())
                {
                    myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                    currentPlayerInMyTeam = IndexPath()
                }
                if (currentPlayerInEnemyTeam != IndexPath())
                {
                    enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                    currentPlayerInEnemyTeam = IndexPath()
                }
                if (currentTeam.name == statRead[id].stat!.myTeam.name)
                {
                    myTeamButton(collectionView)
                }
                if (currentTeam.name == statRead[id].stat!.enemyTeam.name)
                {
                    enemyTeamButton(collectionView)
                }
            }
            else
            {
                currentTimeZone = String(indexPath.row + 1)
                cell?.backgroundColor = .red
                
                var count = 0
                if currentPlayerInMyTeam != IndexPath()
                {
                    while (count < 14)
                    {
                        switch currentTimeZone {
                        case "1":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].firstTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].firstTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        case "2":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].secondTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].secondTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        case "3":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].thirdTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].thirdTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        default:
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].fourthTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInMyTeam.row].fourthTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        }
                        
                        count += 1
                    }
                    for item in labels
                    {
                        item.isHidden = false
                    }
                    
                }
                else if currentPlayerInEnemyTeam != IndexPath()
                {
                    while (count < 14)
                    {
                        
                        switch currentTimeZone {
                        case "1":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].firstTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].firstTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        case "2":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].secondTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].secondTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                            
                        case "3":
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].thirdTime[count][0]
                            let shots = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].thirdTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                            
                        default:
                            let win = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].fourthTime[count][0]
                            let shots = statRead[id].stat!.myTeam.players[currentPlayerInEnemyTeam.row].fourthTime[count][1]
                            labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        }
                        print(count)
                        count += 1
                    }
                    for item in labels
                    {
                        item.isHidden = false
                    }
                    
                }
                else if currentTeam.name == statRead[id].stat!.myTeam.name
                {
                    let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.myTeam.players, oneTime: true)
                    for i in 0...13
                    {
                        labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
                    }
                    for item in labels
                    {
                        item.isHidden = false
                    }
                    myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                    currentPlayerInMyTeam = IndexPath()
                    enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                    currentPlayerInEnemyTeam = IndexPath()
                    
                    
                }
                else if currentTeam.name == statRead[id].stat!.enemyTeam.name
                {
                    let result = StaticInTime(numTime: currentTimeZone, players: statRead[id].stat!.enemyTeam.players, oneTime: true)
                    for i in 0...13
                    {
                        labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
                    }
                    for item in labels
                    {
                        item.isHidden = false
                    }
                    myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                    currentPlayerInMyTeam = IndexPath()
                    enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                    currentPlayerInEnemyTeam = IndexPath()
                }
            }
        }
        if (collectionView == myTeamColView)
        {
            if currentTimeZone == "Field"
            {
                let alert = UIAlertController(title:" Внимание", message: "Вы не выбрали тайм🙀", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let cell = collectionView.cellForItem(at: indexPath)
                cell?.backgroundColor = .red
                myTeamButtonOutlet.backgroundColor = .orange
                enemyTeamButtonOutlet.backgroundColor = .orange
                var count = 0
                while (count < 14)
                {
                    switch currentTimeZone
                    {
                    case "1":
                        let win = statRead[id].stat!.myTeam.players[indexPath.row].firstTime[count][0]
                        let shots = statRead[id].stat!.myTeam.players[indexPath.row].firstTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "2":
                        let win = statRead[id].stat!.myTeam.players[indexPath.row].secondTime[count][0]
                        let shots = statRead[id].stat!.myTeam.players[indexPath.row].secondTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "3":
                        let win = statRead[id].stat!.myTeam.players[indexPath.row].thirdTime[count][0]
                        let shots = statRead[id].stat!.myTeam.players[indexPath.row].thirdTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        
                    default:
                        let win = statRead[id].stat!.myTeam.players[indexPath.row].fourthTime[count][0]
                        let shots = statRead[id].stat!.myTeam.players[indexPath.row].fourthTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    }
                    
                    count += 1
                }
                for item in labels
                {
                    item.isHidden = false
                }
                currentPlayerInMyTeam = indexPath
                enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                currentPlayerInEnemyTeam = IndexPath()
            }
        }
        if (collectionView == enemyTeamColView)
        {
            if (currentTimeZone == "Field")
            {
                let alert = UIAlertController(title:" Внимание", message: "Вы не выбрали тайм🙀", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let cell = collectionView.cellForItem(at: indexPath)
                cell?.backgroundColor = .red
                myTeamButtonOutlet.backgroundColor = .orange
                enemyTeamButtonOutlet.backgroundColor = .orange
                var count = 0
                while (count < 14)
                {
                    switch currentTimeZone
                    {
                    case "1":
                        let win = statRead[id].stat!.enemyTeam.players[indexPath.row].firstTime[count][0]
                        let shots = statRead[id].stat!.enemyTeam.players[indexPath.row].firstTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "2":
                        let win = statRead[id].stat!.enemyTeam.players[indexPath.row].secondTime[count][0]
                        let shots = statRead[id].stat!.enemyTeam.players[indexPath.row].secondTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "3":
                        let win = statRead[id].stat!.enemyTeam.players[indexPath.row].thirdTime[count][0]
                        let shots = statRead[id].stat!.enemyTeam.players[indexPath.row].thirdTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        
                    default:
                        let win = statRead[id].stat!.enemyTeam.players[indexPath.row].fourthTime[count][0]
                        let shots = statRead[id].stat!.enemyTeam.players[indexPath.row].fourthTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    }
                    count += 1;
                }
                for item in labels
                {
                    item.isHidden = false
                }
                currentPlayerInEnemyTeam = indexPath
                myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                currentPlayerInMyTeam = IndexPath()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == numTimeZone)
        {
            return CGSize(width: 30, height: 30)
        }
        else
        {
            return CGSize(width: 50, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = .orange
    }
}
