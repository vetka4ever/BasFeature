//
//  addView.swift
//  BasketApp
//
//  Created by Daniil on 02.02.2021.
//

import UIKit
import RealmSwift


class addView: UIViewController
{
    var addViewPlayers = [UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),UITextField(),]
    var nameTeamsCellid = "TeamsCell"
    var namePlayerCellid = "PlayerCell"
    var addButtonCellid = "ButtonCell"
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        //Присвоить информацию и делегат tableView от TeamsView
        tableView.dataSource = self
        tableView.delegate = self
        //Зарегистрировать ячейки
        tableView.register(UINib(nibName: "nameTeamsCell", bundle: nil), forCellReuseIdentifier: nameTeamsCellid)
        tableView.register(UINib(nibName: "namePlayerCell", bundle: nil), forCellReuseIdentifier: namePlayerCellid)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        // Добавить наблюдателей для появления и исчезновения клавиатуры
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    @IBOutlet var tableView: UITableView!
    func registerKeyboardNotifications()
    {
        //Добавить наблюдателей перед появлением и исчезанием клавиатуры
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: kbWillShow(_:))
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: kbWillHide(_:))
    }
    
    func removeKeyboardNotifications()
    {
        //Удалить наблюдателей перед появлением и исчезанием клавиатуры
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func kbWillShow(_ notification: Notification)
    {
        // Высчитать высоту клавиатуры
        let userInfo = notification.userInfo
        let kbSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        //Сдвинуть контент
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
    }
    @objc func kbWillHide(_ notification: Notification)
    {
        //Вернуть клавиатуру в исходное положение
        tableView.contentInset = UIEdgeInsets.zero
    }
}

extension addView : UITableViewDelegate, UITableViewDataSource
{
    /*
     Добавить количество секций
     0 - секция для введения названия команды
     1 - секция для введения игроков
     2 - секция для добавления команды в БД
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    /*
     Добавить количество ячеек
     0 и 2 - по одной ячейке для названия команды или кнопки добавления
     1 - 12 ячеек для игроков
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 || section == 2
        {
            return 1
        }
        else
        {
            return 12
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Создать ячейку для введения названия команды
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: nameTeamsCellid, for: indexPath) as! nameTeamsCell
            cell.selectionStyle = .none
            addViewPlayers[0] = cell.TextField
            cell.backgroundColor = .white
            return cell
        }
        //Создать ячейку для введения номеров игроков
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: namePlayerCellid, for: indexPath) as! namePlayerCell
            cell.selectionStyle = .none
            cell.namePlayer.text = "Игрок № "
            if (addViewPlayers.count <= 13)
            {
                addViewPlayers[indexPath.row+1] = cell.textField
            }
            return cell
        }
        //Создать ячейку с кнопкой добавления команды
        else
        {
            let cell = UITableViewCell(style: .default, reuseIdentifier: addButtonCellid)
            cell.textLabel?.text = "Добавить команду"
            cell.textLabel?.textAlignment = .center
            cell.backgroundColor = .green
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    
        if indexPath.section == 2
        {
            // Проверить забыл ли пользователь что-то ввести
            var flag = false
            for item in addViewPlayers
            {
                if item.text?.isEmpty == true
                {
                    flag = true
                }
            }
            if flag
            {
                //Предупредить пользователя
                let attention = UIAlertController(title: "Хмм...🧐", message: "Похоже вы что-то забыли указать🥺", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                attention.addAction(ok)
                present(attention, animated: true, completion: nil)
            }
            else
            {
                // Записать команду в БД
                try! realm.write{
                    let obj = MyRealObject()
                    let comand = createComand(array: addViewPlayers)
                    obj.myStruct = comand
                    realm.add(obj)
                }
                // Уведомить о записи команды в БД
                let attention = UIAlertController(title: "Ура 🥳", message: "Команда добавллена", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Хорошо", style: .default) {
                    (action) in
                    
                    self.navigationController?.popViewController(animated: true) 
                    
                    
                }
                attention.addAction(ok)
                present(attention, animated: true, completion: nil)
                
            }
        }
        else
        {
            tableView.endEditing(true)
            
        }
    }
    //Задать высоту ячеек
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
        
    }
    // Задать заголовки
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0
        {
            return "Название команды"
        }
        else if section == 1
        {
            return "Номера игроков"
        }
        else
        {
            return ""
        }
    }
    // Разместить заголовки по центру
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textAlignment = .center
        }
    }
}

