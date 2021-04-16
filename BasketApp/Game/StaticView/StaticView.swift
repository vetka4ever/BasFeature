//
//  StaticView.swift
//  BasketApp
//
//  Created by Daniil on 17.02.2021.
//

import UIKit

class StaticView: UIViewController {
    
    let idMyTeam = "myTeam"
    let idEnemyTeam = "enemyTeam"
    let numTimeId = "numTime"
    var currentTimeZone = "Field"
    var currentTeam = Comand()
    var currentPlayerInMyTeam = IndexPath()
    var currentPlayerInEnemyTeam = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        StaticImage.image = UIImage(named: "Field")
        
        myTeamColView.dataSource = self
        myTeamColView.delegate = self
        myTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: idMyTeam)
        
        myTeamStaticButtonOutlet.setTitle(myTeamRead[0].myTeam?.name, for: .normal)
        myTeamStaticButtonOutlet.setTitleColor(.black, for: .normal)
        myTeamStaticButtonOutlet.backgroundColor = .orange
        myTeamStaticButtonOutlet.layer.cornerRadius = myTeamStaticButtonOutlet.frame.height / 2
        
        
        enemyTeamColView.delegate = self
        enemyTeamColView.dataSource = self
        enemyTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: idEnemyTeam)
        
        enemyTeamStaticOutlet.setTitle(enemysTeamRead[0].myTeam?.name, for: .normal)
        enemyTeamStaticOutlet.setTitleColor(.black, for: .normal)
        enemyTeamStaticOutlet.backgroundColor = .orange
        enemyTeamStaticOutlet.layer.cornerRadius = enemyTeamStaticOutlet.frame.height / 2
        
        numTimeZoneColView.dataSource = self
        numTimeZoneColView.delegate = self
        numTimeZoneColView.register(UINib(nibName: "numTimeZoneCell", bundle: nil), forCellWithReuseIdentifier: numTimeId)
        
        
        labels = [firstZoneLabel, secondZoneLabel, thirdZoneLabel, fourthZoneLabel, fifthZoneLabel, sixthZoneLabel, seventhZoneLabel, eightthZoneLabel, ninethZoneLabel, tenthZoneLabel, eleventhZoneLabel, twelvethZoneLabel, threteenthZoneLabel, fourteenthZoneLabel]
        for item in labels
        {
            item.isHidden = true
        }
    }
    
    //    @IBOutlet var myTeamLabel: UILabel!
    //    @IBOutlet var enemyTeamLabel: UILabel!
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
    @IBOutlet var numTimeZoneColView: UICollectionView!
    var labels = [UILabel]()
    
    @IBOutlet var myTeamStaticButtonOutlet: UIButton!
    @IBAction func myTeamStaicButton(_ sender: Any)
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
            let result = StaticInTime(numTime: currentTimeZone, players: myTeamRead[0].myTeam!.players, oneTime: true)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            currentTeam = myTeamRead[0].myTeam!
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            myTeamStaticButtonOutlet.backgroundColor = .red
            enemyTeamStaticOutlet.backgroundColor = .orange
        }
    }
    @IBOutlet var enemyTeamStaticOutlet: UIButton!
    @IBAction func enemyTeamStaicButton(_ sender: Any)
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
            let result = StaticInTime(numTime: currentTimeZone, players: enemysTeamRead[0].myTeam!.players, oneTime: true)
            for i in 0...13
            {
                labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
            }
            for item in labels
            {
                item.isHidden = false
            }
            currentTeam = enemysTeamRead[0].myTeam!
            myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
            currentPlayerInMyTeam = IndexPath()
            enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
            currentPlayerInEnemyTeam = IndexPath()
            enemyTeamStaticOutlet.backgroundColor = .red
            myTeamStaticButtonOutlet.backgroundColor = .orange
        }
    }
    
    
    
    @IBOutlet var StaticView: UIView!
    @IBOutlet var StaticImage: UIImageView!
}
extension StaticView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == myTeamColView
        {
            return 8
        }
        else if collectionView == enemyTeamColView
        {
            return 8
        }
        else
        {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.backgroundColor = .blue
        collectionView.layer.cornerRadius = 20
        if collectionView == myTeamColView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idMyTeam, for: indexPath) as! PlayerCell
            cell.backgroundColor = .orange
            cell.playerNum.text = myTeamRead[0].myTeam?.players[indexPath.row].numeric
            
            
            return cell
        }
        else if collectionView == enemyTeamColView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idEnemyTeam, for: indexPath) as! PlayerCell
            cell.backgroundColor = .orange
            cell.playerNum.text = enemysTeamRead[0].myTeam?.players[indexPath.row].numeric
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: numTimeId, for: indexPath) as! numTimeZoneCell
            cell.title.text = String(indexPath.row + 1)
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 15
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myTeamColView || collectionView == enemyTeamColView
        {
            return CGSize(width: 50, height: 50)
        }
        else
        {
            return CGSize(width: 30, height: 30)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if collectionView == myTeamColView
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
                collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
                myTeamStaticButtonOutlet.backgroundColor = .orange
                enemyTeamStaticOutlet.backgroundColor = .orange
                currentPlayerInMyTeam = indexPath
                if currentPlayerInEnemyTeam != IndexPath()
                {
                    enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                    currentPlayerInEnemyTeam = IndexPath()
                }
                var count = 0
                while (count < 14)
                {
                    switch currentTimeZone {
                    case "1":
                        let win = myTeamRead[0].myTeam!.players[indexPath.row].firstTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[indexPath.row].firstTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "2":
                        let win = myTeamRead[0].myTeam!.players[indexPath.row].secondTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[indexPath.row].secondTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "3":
                        let win = myTeamRead[0].myTeam!.players[indexPath.row].thirdTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[indexPath.row].thirdTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    default:
                        let win = myTeamRead[0].myTeam!.players[indexPath.row].fourthTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[indexPath.row].fourthTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    }
                    
                    count += 1
                }
                for item in labels
                {
                    item.isHidden = false
                }
                currentTeam = Comand()
            }
        }
        else if collectionView == enemyTeamColView
        {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
            myTeamStaticButtonOutlet.backgroundColor = .orange
            enemyTeamStaticOutlet.backgroundColor = .orange
            var count = 0
            currentPlayerInEnemyTeam = indexPath
            if currentPlayerInMyTeam != IndexPath()
            {
                myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                currentPlayerInMyTeam = IndexPath()
            }
            while (count < 14)
            {
                
                switch currentTimeZone {
                case "1":
                    let win = enemysTeamRead[0].myTeam!.players[indexPath.row].firstTime[count][0]
                    let shots = enemysTeamRead[0].myTeam!.players[indexPath.row].firstTime[count][1]
                    labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                case "2":
                    let win = enemysTeamRead[0].myTeam!.players[indexPath.row].secondTime[count][0]
                    let shots = enemysTeamRead[0].myTeam!.players[indexPath.row].secondTime[count][1]
                    labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    
                case "3":
                    let win = enemysTeamRead[0].myTeam!.players[indexPath.row].thirdTime[count][0]
                    let shots = enemysTeamRead[0].myTeam!.players[indexPath.row].thirdTime[count][1]
                    labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    
                default:
                    let win = enemysTeamRead[0].myTeam!.players[indexPath.row].fourthTime[count][0]
                    let shots = enemysTeamRead[0].myTeam!.players[indexPath.row].fourthTime[count][1]
                    labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                }
                print(count)
                count += 1
            }
            for item in labels
            {
                item.isHidden = false
            }
            currentTeam = Comand()
        }
        else if collectionView == numTimeZoneColView
        {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
            var count = 0
            currentTimeZone = String(indexPath.row + 1)
            if currentPlayerInMyTeam != IndexPath()
            {
                while (count < 14)
                {
                    switch currentTimeZone {
                    case "1":
                        let win = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].firstTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].firstTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "2":
                        let win = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].secondTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].secondTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "3":
                        let win = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].thirdTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].thirdTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    default:
                        let win = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].fourthTime[count][0]
                        let shots = myTeamRead[0].myTeam!.players[currentPlayerInMyTeam.row].fourthTime[count][1]
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
                        let win = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].firstTime[count][0]
                        let shots = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].firstTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                    case "2":
                        let win = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].secondTime[count][0]
                        let shots = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].secondTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        
                    case "3":
                        let win = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].thirdTime[count][0]
                        let shots = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].thirdTime[count][1]
                        labels[count].text! = String(win) + "/" + String(shots) + "\n" + percent(winShot: win, allShot: shots)
                        
                    default:
                        let win = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].fourthTime[count][0]
                        let shots = enemysTeamRead[0].myTeam!.players[currentPlayerInEnemyTeam.row].fourthTime[count][1]
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
            else if currentTeam.name == myTeamRead[0].myTeam?.name
            {
                let result = StaticInTime(numTime: currentTimeZone, players: myTeamRead[0].myTeam!.players, oneTime: true)
                for i in 0...13
                {
                    labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
                }
                for item in labels
                {
                    item.isHidden = false
                }
                currentTeam = myTeamRead[0].myTeam!
                myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                currentPlayerInMyTeam = IndexPath()
                enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                currentPlayerInEnemyTeam = IndexPath()
                
                
            }
            else if currentTeam.name == enemysTeamRead[0].myTeam?.name
            {
                let result = StaticInTime(numTime: currentTimeZone, players: enemysTeamRead[0].myTeam!.players, oneTime: true)
                for i in 0...13
                {
                    labels[i].text = String(result[i][0]) + "/" + String(result[i][1]) + "\n" + percent(winShot: result[i][0], allShot: result[i][1])
                }
                for item in labels
                {
                    item.isHidden = false
                }
                currentTeam = enemysTeamRead[0].myTeam!
                currentTeam = myTeamRead[0].myTeam!
                myTeamColView.cellForItem(at: currentPlayerInMyTeam)?.backgroundColor = .orange
                currentPlayerInMyTeam = IndexPath()
                enemyTeamColView.cellForItem(at: currentPlayerInEnemyTeam)?.backgroundColor = .orange
                currentPlayerInEnemyTeam = IndexPath()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

