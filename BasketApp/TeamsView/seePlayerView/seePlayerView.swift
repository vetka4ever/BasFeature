//
//  seePlayerInTeamView.swift
//  BasketApp
//
//  Created by Daniil on 09.02.2021.
//

import UIKit


class seePlayerView: UIViewController {
    var arrayTextField = [UITextField]()
    let idCell = "seePlayerCell"
    let idChangeTeam = "ChangeTeam"
    var itemInDataBase = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayTextField.removeAll()
      
        seePlayer.dataSource = self
        seePlayer.delegate = self
        seePlayer.register(UINib(nibName: "seePlayerCell", bundle: nil), forCellReuseIdentifier: idCell)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    func registerKeyboardNotifications()
    {
        //Добавить наблюдателей перед появлением и исчезанием клавиатуры
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: kbWillShow(_:))
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: kbWillHide(_:))
    }
    
    func removeKeyboardNotifications()
    {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func kbWillShow(_ notification: Notification)
    {
        
        let userInfo = notification.userInfo
        let kbSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        seePlayer.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
    }
    @objc func kbWillHide(_ notification: Notification)
    {
        
        seePlayer.contentInset = UIEdgeInsets.zero
    }
    
    
    @IBOutlet var seePlayer: UITableView!
    @IBOutlet var addChangeOutlet: UIButton!
    @IBAction func addChange(_ sender: Any) {
        self.seePlayer.isEditing = false
        print("Количество элеметов в массиве:\(arrayTextField.count)")
        var i = 0
        while i < 12
        {
            if (arrayTextField[i].text != "")
            {
                try! realm.write{
                    dataBase[itemInDataBase].myStruct?.players[i].numeric = arrayTextField[i].text!
                }
            }
            i += 1
        }
        
        let alert = UIAlertController(title: "Ура", message: "Команда изменена", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default) {
            (action) in goToView(VC: self, newVC: "TeamsView")}
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        arrayTextField.removeAll()
    }
    
    
    
}




extension seePlayerView: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            return 13
        }
        else
        {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 14 && indexPath.section == 0
        {
            print(indexPath.row)
            let cell =  tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! seePlayerCell
            cell.selectionStyle = .none
            if (indexPath.row == 0)
            {
                cell.playerTitle.text = dataBase[itemInDataBase].myStruct!.name
                cell.textField.keyboardType = .default
            }
            else
            {
                cell.playerTitle.text = String("Игрок № ") +  dataBase[itemInDataBase].myStruct!.players[indexPath.row - 1].numeric
                cell.textField.keyboardType = .numberPad
            }
            if arrayTextField.count < 14
            {
                arrayTextField.append(cell.textField)
            }
            
            return cell
        }
        else if indexPath.row < 1 && indexPath.section == 1
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: idChangeTeam)
            cell.textLabel?.text = "Внести изменения"
            cell.backgroundColor = . green
            cell.textLabel?.textAlignment = .center
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {
            return "Команда"
        }
        else
        {
            return ""
        }
        
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let playerToMove = arrayTextField[sourceIndexPath.row]
        arrayTextField.remove(at: sourceIndexPath.row)
        arrayTextField.insert(playerToMove, at: destinationIndexPath.row)
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0
        {
            return true
        }
        else
        {
            return false
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            print("Количество элеметов в массиве:\(arrayTextField.count)")
            if (arrayTextField[0].text != "")
            {
                try! realm.write
                {
                    dataBase[itemInDataBase].myStruct?.name = arrayTextField[0].text!
                }
                
            }
            var i = 0
            while i < 12
            {
                try! realm.write{
                    
                    dataBase[itemInDataBase].myStruct?.players[i].numeric = arrayTextField[i+1].text!
                }
                i += 1
            }
            if dataBase[itemInDataBase].myStruct?.name == myTeamRead[0].myTeam?.name
            {
                try! myTeamWrite.write
                {
                    myTeamRead[0].myTeam = dataBase[itemInDataBase].myStruct
                }
            }
            if dataBase[itemInDataBase].myStruct?.name == enemysTeamRead[0].myTeam?.name
            {
                try! enemysTeamWrite.write
                {
                    enemysTeamRead[0].myTeam = dataBase[itemInDataBase].myStruct
                }
            }
            let alert = UIAlertController(title: "Ура", message: "Изменения добавлены", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default) {
                (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            arrayTextField.removeAll()
        }
        else
        {
            seePlayer.endEditing(true)
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView
        {
            headerView.textLabel?.textAlignment = .center
        }
    }
}




