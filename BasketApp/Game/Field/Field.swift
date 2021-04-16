//
//  Field.swift
//  BasketApp
//
//  Created by Daniil on 10.12.2020.
//
import UIKit
import Foundation
import RealmSwift
var currentZone: String = "Field"
fileprivate var currentTimeZone = "Field"
class Field: UIViewController, UIGestureRecognizerDelegate
{
    // OUTLET
    let myPlayerCell = "myPlayerCell"
    let enemyPlayerCell = "EnemyPlayerCell"
    let numTimeZone = "numTimeZoneCell"
    @IBOutlet var MyTeamColView: UICollectionView!
    @IBOutlet var EnemyTeamColView: UICollectionView!
    @IBOutlet var numTimeColView: UICollectionView!
    @IBOutlet var FieldView: UIView!
    @IBOutlet var FieldImage: UIImageView!
    @IBOutlet var myTeamLabel: UILabel!
    @IBOutlet var enemyTeamLabel: UILabel!
    @IBAction func backToMenu(_ sender: Any)
    {
        let alert = UIAlertController(title: "Внимени", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
        let ok  = UIAlertAction(title: "Да", style: .destructive) {
            (action) in
            try! statWrite.write
            {
                let object = TeamStatic()
                var currentStat = GameStatic()
                currentStat.myTeam = myTeamRead[0].myTeam!
                currentStat.enemyTeam = enemysTeamRead[0].myTeam!
                currentStat.currentDate = currentDate()
                object.stat = currentStat
                statWrite.add(object)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        let no = UIAlertAction(title: "Нет", style: .default, handler: nil)
        alert.addAction(ok)
        alert.addAction(no)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    //-----------------
    override func viewDidLoad()
    {
        
        //Очистить статистику игроков в выбранной команде
        try! myTeamWrite.write
        {
            for i in 0...11
            {
                myTeamRead[0].myTeam?.players[i].firstTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                myTeamRead[0].myTeam?.players[i].secondTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                myTeamRead[0].myTeam?.players[i].thirdTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                myTeamRead[0].myTeam?.players[i].fourthTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
            }
        }
        try! enemysTeamWrite.write
        {
            for i in 0...11
            {
                enemysTeamRead[0].myTeam?.players[i].firstTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                enemysTeamRead[0].myTeam?.players[i].secondTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                enemysTeamRead[0].myTeam?.players[i].thirdTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                enemysTeamRead[0].myTeam?.players[i].fourthTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
                
            }
        }
        //Зарегистрировать касание
        let tap = UITapGestureRecognizer(target: self, action: #selector(selector))
        FieldView.addGestureRecognizer(tap)
        //Настроить скрол и название выбранной команды и зарегистрировать ячейку
        MyTeamColView.dataSource = self
        MyTeamColView.delegate = self
        MyTeamColView.backgroundColor = .blue
        MyTeamColView.layer.cornerRadius = 20
        myTeamLabel.text = myTeamRead[0].myTeam?.name
        self.MyTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: myPlayerCell)
        //Настроить скрол и название команды противника и зарегистрировать ячейку
        EnemyTeamColView.delegate = self
        EnemyTeamColView.dataSource = self
        EnemyTeamColView.backgroundColor = .blue
        EnemyTeamColView.layer.cornerRadius = 20
        enemyTeamLabel.text = enemysTeamRead[0].myTeam?.name
        self.EnemyTeamColView.register(UINib(nibName: "PlayerCell", bundle: nil), forCellWithReuseIdentifier: enemyPlayerCell)
        // Настроить табло с таймами
        numTimeColView.dataSource = self
        numTimeColView.delegate = self
        numTimeColView.backgroundColor = .blue
        numTimeColView.layer.cornerRadius = 20
        self.numTimeColView.register(UINib(nibName: "numTimeZoneCell", bundle: nil), forCellWithReuseIdentifier: numTimeZone)
        
    }
    //Посмотреть статистику
    @IBAction func goToStatistics(_ sender: Any)
    {
        let newVC = storyboard?.instantiateViewController(identifier: "StaticView") as! StaticView
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    //Выделить нажатую зону
    @objc private func selector(_ touch: UITapGestureRecognizer)
    {
        //Получить координаты нажатия
        let touchPoint = touch.location(in: FieldView)
        let x = Int(touchPoint.x)
        let y = Int(touchPoint.y)
        //Проверить наличие картинки
        if let image = FieldImage.image
        {
            //Получить цвет
            let color = pixel(image: image, x: x, y: y)
            //Получить номер image(смотреть assets)
            let numZone = numberZone(color: color, x: x, y: y)
            //Обновить image & current zone
            currentZone = numZone
            FieldImage.image = UIImage(named: numZone)
        }
        else
        {
            print("ERROR IN IMAGE")
        }
    }
}
extension Field: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    //MARK: Задать количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == numTimeColView
        {
            return 4
        }
        else
        {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //MARK: Задать ячейки для выбранной команды
        if collectionView == MyTeamColView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myPlayerCell , for: indexPath) as! PlayerCell
            cell.playerNum.text = myTeamRead[0].myTeam?.players[indexPath.row].numeric
            cell.backgroundColor = .orange
            
            return cell
        }
        //MARK: Задать ячейки для команды противника
        else if collectionView == EnemyTeamColView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:enemyPlayerCell , for: indexPath) as! PlayerCell
            cell.playerNum.text = enemysTeamRead[0].myTeam?.players[indexPath.row].numeric
            cell.backgroundColor = .orange
            
            return cell
        }
        //MARK: Задать ячейки для табло
        else if collectionView == numTimeColView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: numTimeZone , for: indexPath) as! numTimeZoneCell
            cell.title.text = String(indexPath.row + 1)
            cell.backgroundColor = .orange
            cell.layer.cornerRadius = 15
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //Задать размеры ячеек
        if collectionView == numTimeColView
        {
            return CGSize(width: 30 , height: 30)
        }
        else
        {
            return CGSize(width: 50 , height: 50)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        // Выделить выбранного игрока
        if collectionView == numTimeColView
        {
            currentTimeZone = String(indexPath.row + 1)
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.backgroundColor = .red
            print("Выбран \(indexPath.row + 1) тайм")
        }
        else if currentTimeZone == "Field"
        {
            let alert = UIAlertController(title: "Внимание", message: "Вы не выбрали тайм🙀", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        //Проверить выбрана ли зона
        else if currentZone == "Field"
        {
            let alert = UIAlertController(title: "Внимание", message: "Вы не выбрали зону🙀", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        //MARK: Настроить Alert для скролла выбранной команды
        else if collectionView == MyTeamColView
        {
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
            let alert = UIAlertController(title: "Игрок №\(myTeamRead[0].myTeam!.players[indexPath.row].numeric)", message: "Команда \(myTeamRead[0].myTeam!.name)\nВыберите дейстие", preferredStyle: .alert)
            let lazyShot = UIAlertAction(title: "Бросок", style: .default)
            { (action) in
                try! myTeamWrite.write
                {
                    switch currentTimeZone
                    {
                    case "2":
                        myTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][1] += 1
                        break
                    case "3":
                        myTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][1] += 1
                        break
                    case "4":
                        myTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1 ][1] += 1
                        break
                        
                    default:
                        myTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][1] += 1
                        
                        break
                    }
                }
                let alert = UIAlertController(title: "⛹🏻‍♂️", message: "Бросок засчитан", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            alert.addAction(lazyShot)
            
            let winShot = UIAlertAction(title: "Попадание", style: .default)
            {
                (action) in
                try! myTeamWrite.write
                {
                    switch currentTimeZone
                    {
                    case "2" :
                        myTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][1] += 1
                        myTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][0] += 1
                        break
                    case "3" :
                        myTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][1] += 1
                        myTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][0] += 1
                        break
                    case "4" :
                        myTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1][1] += 1
                        myTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1][0] += 1
                        break
                    default :
                        myTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][1] += 1
                        myTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][0] += 1
                        
                    }
                }
                collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
                let alert = UIAlertController(title: "⛹🏻‍♂️", message: "Попадание засчитано", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            alert.addAction(winShot)
            let error = UIAlertAction(title: "Ошибка", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
            alert.addAction(error)
            self.present(alert, animated: true, completion: nil)
            collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange
        }
        //MARK: Настроить Alert для скролла команды противника
        else if collectionView == EnemyTeamColView
        {
            let alert = UIAlertController(title: "Игрок №\(enemysTeamRead[0].myTeam!.players[indexPath.row].numeric)", message: "Команда \(enemysTeamRead[0].myTeam!.name)\nВыберите дейстие", preferredStyle: .alert)
            let lazyShot = UIAlertAction(title: "Бросок", style: .default)
            { (action) in
                try! enemysTeamWrite.write{
                    switch currentTimeZone
                    {
                    case "2": enemysTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][1] += 1
                        break
                    case "3":
                        enemysTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][1] += 1
                        break
                    case "4":
                        enemysTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1][1] += 1
                        break
                        
                    default:
                        enemysTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][1] += 1
                    }
                }
                let alert = UIAlertController(title: "⛹🏻‍♂️", message: "Бросок засчитан", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            alert.addAction(lazyShot)
            let winShot = UIAlertAction(title: "Попадание", style: .default)
            {
                (action) in
                try! enemysTeamWrite.write{
                    switch currentTimeZone
                    {
                    case "2" :
                        enemysTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][1] += 1
                        enemysTeamRead[0].myTeam?.players[indexPath.row].secondTime[Int(currentZone)! - 1][0] += 1
                        break
                    case "3" :
                        enemysTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][1] += 1
                        enemysTeamRead[0].myTeam?.players[indexPath.row].thirdTime[Int(currentZone)! - 1][0] += 1
                        break
                    case "4" :
                        enemysTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1][1] += 1
                        enemysTeamRead[0].myTeam?.players[indexPath.row].fourthTime[Int(currentZone)! - 1][0] += 1
                        break
                    default :
                        enemysTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][1] += 1
                        enemysTeamRead[0].myTeam?.players[indexPath.row].firstTime[Int(currentZone)! - 1][0] += 1
                    }
                }
                let alert = UIAlertController(title: "⛹🏻‍♂️", message: "Попадание засчитано", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
            alert.addAction(winShot)
            let error = UIAlertAction(title: "Ошибка", style: .default) {(action) in collectionView.cellForItem(at: indexPath)?.backgroundColor = .orange}
            alert.addAction(error)
            self.present(alert, animated: true, completion: nil)
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

