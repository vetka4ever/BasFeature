//
//  UserInfoTableViewController.swift
//  BasketApp
//
//  Created by Daniil on 08.04.2021.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON
import SideMenu
class UserInfo: UITableViewController
{
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        self.tableView = .init(frame : self.view.frame, style: .insetGrouped)
        self.tableView.beginUpdates()
        self.tableView.backgroundColor = .orange
        self.tableView.endUpdates()
        if (userRead[0].infoUser?.api_Key != "")
        {
            nameUser = userRead[0].infoUser!.lastName + "\n" + userRead[0].infoUser!.firstName + "\n" + userRead[0].infoUser!.middleName
        }
        
    }
    var nameUser = ""
    var toDoField = UITextField()
    func TextFieldHandler(note: UITextField)
    {
        toDoField = note
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //
        
        
        
        let cellNames = [nameUser, "Изменить данные", "Изменить логин", "Изменить пароль", "Удалить аккаунт", "Выйти"]
        print(nameUser)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UserCell")
        if (indexPath.section == 0)
        {
            cell.imageView?.image = #imageLiteral(resourceName: "icons8-administrator-male-80")
            cell.selectionStyle = .none
            tableView.cellForRow(at: indexPath)?.widthAnchor
        }
        cell.textLabel?.text = cellNames[indexPath.section]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        return cell
    }
    let sessionManager: Session = {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = ["46.17.104.151": DisabledTrustEvaluator()]
        return Session(serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies)
        )}()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            let alert = UIAlertController(title: "Укажите нуждающиеся в замене данные и логин", message: "", preferredStyle: .alert)
            for _ in 0...3
            {
                alert.addTextField(configurationHandler: TextFieldHandler)
            }
            alert.textFields?[0].placeholder = "Фамилия"
            alert.textFields?[1].placeholder = "Имя"
            alert.textFields?[2].placeholder = "Отчество"
            alert.textFields?[3].placeholder = "Логин"
            let ok = UIAlertAction(title: "Изменить данные", style: .destructive)
            { [self]
                (action) in
                let userInfo = userRead[0].infoUser
                var lastName = alert.textFields?[0].text
                var name = alert.textFields?[1].text
                var middleName = alert.textFields?[2].text
                if (lastName == "" || name == "" || middleName == "")
                {
                    if (lastName == "")
                    {
                        lastName = userInfo!.lastName
                    }
                    
                    if (name == "")
                    {
                        name = userInfo!.lastName
                    }
                    
                    if (middleName == "")
                    {
                        middleName = userInfo!.middleName
                    }
                }
                let username = alert.textFields?[3].text
                
                let url = String("https://46.17.104.151:5000/probasket/authorization?type=edit_fio&api_key=\(userInfo!.api_Key)&username=\(username!)&first_name=\(name!)&last_name=\(lastName!)&middle_name=\(middleName!)")
                print(url)
                sessionManager.request(url).responseJSON(completionHandler:
                                                            {(response) in
                                                                let data = JSON(response.data)
                                                                print(data)
                                                                if data["code"] == 200
                                                                {
                                                                    try! userWrite.write
                                                                    {
                                                                        userRead[0].infoUser?.api_Key = data["user"]["api_key"].stringValue
                                                                        userRead[0].infoUser?.firstName = data["user"]["first_name"].stringValue
                                                                        userRead[0].infoUser?.lastName = data["user"]["last_name"].stringValue
                                                                        userRead[0].infoUser?.middleName = data["user"]["middle_name"].stringValue
                                                                    }
                                                                    
                                                                    let succesfulAlert = UIAlertController(title: "Данные успешно изменены", message: "", preferredStyle: .alert)
                                                                    let sucOk = UIAlertAction(title: "Хорошо", style: .default)
                                                                    {
                                                                        (action) in
                                                                        nameUser = userRead[0].infoUser!.lastName + "\n" + userRead[0].infoUser!.firstName + "\n" + userRead[0].infoUser!.middleName
                                                                        self.tableView.reloadData()
                                                                    }
                                                                    succesfulAlert.addAction(sucOk)
                                                                    self.present(succesfulAlert, animated: true, completion: nil)
                                                                }
                                                                if data["code"] == 400
                                                                {
                                                                    let succesfulAlert = UIAlertController(title: "Неверный логин", message: "Не удалось найти пользователя в базе данных", preferredStyle: .alert)
                                                                    let sucOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                    succesfulAlert.addAction(sucOk)
                                                                    self.present(succesfulAlert, animated: true, completion: nil)
                                                                }
                                                                if data["code"] == 403
                                                                {
                                                                    let succesfulAlert = UIAlertController(title: "Отказано в доступе", message: "", preferredStyle: .alert)
                                                                    let sucOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                    succesfulAlert.addAction(sucOk)
                                                                    self.present(succesfulAlert, animated: true, completion: nil)
                                                                }
                                                                if data["code"] == 404
                                                                {
                                                                    let succesfulAlert = UIAlertController(title: "Переданы неверные данные", message: "", preferredStyle: .alert)
                                                                    let sucOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                    succesfulAlert.addAction(sucOk)
                                                                    self.present(succesfulAlert, animated: true, completion: nil)
                                                                }
                                                                if data["code"] == 500
                                                                {
                                                                    let succesfulAlert = UIAlertController(title: "Ошибка на сервере", message: "", preferredStyle: .alert)
                                                                    let sucOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                    succesfulAlert.addAction(sucOk)
                                                                    self.present(succesfulAlert, animated: true, completion: nil)
                                                                }
                                                            })
                tableView.deselectRow(at: indexPath, animated: false)
            }
            
            let no = UIAlertAction(title: "Отмена", style: .cancel)
            {
                (action) in tableView.deselectRow(at: indexPath, animated: false)
            }
            alert.addAction(ok)
            alert.addAction(no)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        if indexPath.section == 2
        {
            let alert = UIAlertController(title: "Введите данные", message: "", preferredStyle: .alert)
            for _ in 0...2
            {
                alert.addTextField(configurationHandler: TextFieldHandler)
            }
            alert.textFields?[0].placeholder = "Новый логин"
            alert.textFields?[1].placeholder = "Прежний логин"
            alert.textFields?[2].placeholder = "Пароль"
            let ok = UIAlertAction(title: "Изменить логин", style: .destructive)
            { [self] (action) in
                let newLog = alert.textFields?[0].text
                let oldLog = alert.textFields?[1].text
                let password = alert.textFields?[2].text
                let api = userRead[0].infoUser?.api_Key
                let url = String("https://46.17.104.151:5000/probasket/authorization?type=edit_username&api_key=\(api!)&username=\(oldLog!)&pas=\(password!)&new_username=\(newLog!)")
                sessionManager.request(url).responseJSON(completionHandler: {
                    (response) in
                    let data = JSON(response.data)
                    print (data)
                    if data["code"] == 200
                    {
                        let congratulation = UIAlertController(title: "Поздравляю", message: "Логин успешно изменен", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    //                    if data["code"] == 400
                    //                    {
                    //                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин", preferredStyle: .alert)
                    //                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    //                        congratulation.addAction(ok)
                    //                        self.present(congratulation, animated: true, completion: nil)
                    //                    }
                    if data["code"] == 403
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин или пароль", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 404
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "В указанных данных присутствуют пустые поля", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 500
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Ошибка на сервере", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                })
                tableView.deselectRow(at: indexPath, animated: false)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .default)
            {
                (action) in tableView.deselectRow(at: indexPath, animated: false)
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        if indexPath.section == 3
        {
            let alert = UIAlertController(title: "Введите данные", message: "", preferredStyle: .alert)
            for _ in 0...2
            {
                alert.addTextField(configurationHandler: TextFieldHandler)
            }
            alert.textFields?[0].placeholder = "Логин"
            alert.textFields?[1].placeholder = "Прежний пароль"
            alert.textFields?[2].placeholder = "Новый пароль"
            let ok = UIAlertAction(title: "Изменить пароль", style: .destructive)
            { [self] (action) in
                let username = alert.textFields?[0].text
                let oldPas = alert.textFields?[1].text
                let newPas = alert.textFields?[2].text
                let api = userRead[0].infoUser?.api_Key
                let url = String("https://46.17.104.151:5000/probasket/authorization?type=edit_pas&api_key=\(api!)&username=\(username!)&pas=\(oldPas!)&new_pas=\(newPas!)")
                sessionManager.request(url).responseJSON(completionHandler: {
                    (response) in
                    let data = JSON(response.data)
                    print (data)
                    if data["code"] == 200
                    {
                        let congratulation = UIAlertController(title: "Поздравляю", message: "Пароль успешно изменен", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 400
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 403
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин или пароль", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 404
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "В указанных данных присутствуют пустые поля", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 500
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Ошибка на сервере", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                })
                tableView.deselectRow(at: indexPath, animated: false)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .default)
            {
                (action) in tableView.deselectRow(at: indexPath, animated: false)
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        if indexPath.section == 4
        {
            let alert = UIAlertController(title: "Введите данные", message: "", preferredStyle: .alert)
            for _ in 0...1
            {
                alert.addTextField(configurationHandler: TextFieldHandler)
            }
            alert.textFields?[0].placeholder = "Логин"
            alert.textFields?[1].placeholder = "Пароль"
            let ok = UIAlertAction(title: "Удалить аккаунт", style: .destructive)
            { [self] (action) in
                let username = alert.textFields?[0].text
                let password = alert.textFields?[1].text
                let api = userRead[0].infoUser?.api_Key
                let url = String("https://46.17.104.151:5000/probasket/authorization?type=delete_account&username=\(username!)&pas=\(password!)&api_key=\(api!)")
                sessionManager.request(url).responseJSON(completionHandler: {
                    (response) in
                    let data = JSON(response.data)
                    print (data)
                    if data["code"] == 200
                    {
                        let congratulation = UIAlertController(title: "Поздравляю", message: "Аккаунт успешно удален", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default)
                        {
                            (action) in
                            try! userWrite.write
                            {
                                userRead[0].infoUser = User()
                            }
                            dismiss(animated: true, completion: nil)
                            
                            
                        }
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                        
                        
                    }
                    if data["code"] == 400
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 403
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Указан неверный логин или пароль", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 404
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "В указанных данных присутствуют пустые поля", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                    if data["code"] == 500
                    {
                        let congratulation = UIAlertController(title: "Внимание", message: "Ошибка на сервере", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                        congratulation.addAction(ok)
                        self.present(congratulation, animated: true, completion: nil)
                    }
                })
                tableView.deselectRow(at: indexPath, animated: false)
            }
            let cancel = UIAlertAction(title: "Отмена", style: .default)
            {
                (action) in tableView.deselectRow(at: indexPath, animated: false)
            }
            alert.addAction(ok)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        if indexPath.section == 5
        {
            
            try! userWrite.write
            {
                userRead[0].infoUser = User()
            }
            dismiss(animated: true, completion: nil)
        }
    }
}


