//
//  ViewController.swift
//  BasketApp
//
//  Created by Даниил on 09.10.2020.
//
import UIKit
import SideMenu
import RealmSwift
import Alamofire
import SwiftyJSON
class Menu: UIViewController
{
    
    @IBAction func deleteUserInfo(_ sender: Any)
    {
        try! toDoWrite.write
        {
            toDoWrite.delete(toDoRead)
        }
        toDoView.reloadData()
    }
    var menu : SideMenuNavigationController?
    var idCell = "TodoNote"
    @IBOutlet var toDoView: UITableView!
    @IBOutlet var tabBar: UITabBar!
    
   
    
    override func viewDidLoad() {
        tabBar.delegate = self
        toDoView.dataSource = self
        toDoView.delegate = self
        super.viewDidLoad()
        userButtonOutlet.image = UIImage(systemName: "line.horizontal.3")
        
        menu = SideMenuNavigationController(rootViewController: UserInfo())
// SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        menu?.leftSide = true
    }
    var toDoField = UITextField()
    func toDoHandler(note: UITextField)
    {
        toDoField = note
    }
    @IBAction func showToDo(_ sender: Any)
    {
        let alert = UIAlertController(title: "Заметка", message: "Введите заметку", preferredStyle: .alert)
        alert.addTextField(configurationHandler: toDoHandler)
        let ok = UIAlertAction(title: "Добавить", style: .default)
        {
            (action) in
            try! toDoWrite.write
            {
                let object = Todo()
                object.note = self.toDoField.text!
                toDoWrite.add(object)
            }
            self.toDoView.reloadData()
        }
        let no = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(ok)
        alert.addAction(no)
        print(toDoRead.count)
        self.present(alert, animated: true, completion: nil)
    }
    let sessionManager: Session = {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = ["46.17.104.151": DisabledTrustEvaluator()]
        return Session(serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies)
        )}()
    
    @IBOutlet var userButtonOutlet: UIBarButtonItem!
    @IBAction func userButton(_ sender: Any)
    {
        
        if (userRead[0].infoUser?.api_Key == "" || userRead[0].infoUser?.api_Key == nil)
        {
            let alert = UIAlertController(title: "Выберите действие", message: "", preferredStyle: .alert)
            let logIN = UIAlertAction(title: "Регистриция", style: .default)
            { (action) in
                let loginAlert = UIAlertController(title: "Введите данные", message: "", preferredStyle: .alert)
                for item in 0...4{
                    loginAlert.addTextField(configurationHandler: self.toDoHandler)
                }
                loginAlert.textFields?[0].placeholder = "Имя"
                loginAlert.textFields?[1].placeholder = "Фамилия"
                loginAlert.textFields?[2].placeholder = "Отчество"
                loginAlert.textFields?[3].placeholder = "Логин"
                loginAlert.textFields?[4].placeholder = "Пароль"
                let ok = UIAlertAction(title: "Зарегистрироваться", style: .default)
                { [self]
                    (action) in
                    let name = loginAlert.textFields?[0].text
                    let lastname = loginAlert.textFields?[1].text
                    let middlename = loginAlert.textFields?[2].text
                    let username = loginAlert.textFields?[3].text
                    let password = loginAlert.textFields?[4].text
                    
                    let url = String("https://46.17.104.151:5000/probasket/authorization?type=registration&first_name=\(name!)&last_name=\(lastname!)&middle_name=\(middlename!)&username=\(username!)&pas=\(password!)")
                    sessionManager.request(url).responseJSON(completionHandler:
                                                                {(response) in
                                                                    let data = JSON(response.data)
                                                                    print(data)
                                                                    if data["code"] == 200
                                                                    {
                                                                        try! userWrite.write
                                                                        {
                                                                            var object = User()
                                                                            object.firstName = name!
                                                                            object.lastName = lastname!
                                                                            object.middleName = middlename!
                                                                            object.api_Key = data["user"]["api_key"].stringValue
                                                                            userRead[0].infoUser = object
                                                                        }
                                                                        let errorAlert = UIAlertController(title: "Поздравляю", message: "Вы успешно зарегистрировались", preferredStyle: .alert)
                                                                        let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                        errorAlert.addAction(errorOk)
                                                                        self.present(errorAlert, animated: true, completion: nil)
                                                                    }
                                                                    if data["code"] == 400
                                                                    {
                                                                        let errorAlert = UIAlertController(title: "Внимание", message: "Пользователь с такими данными уже зарегистрирован", preferredStyle: .alert)
                                                                        let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                        errorAlert.addAction(errorOk)
                                                                        self.present(errorAlert, animated: true, completion: nil)
                                                                    }
                                                                    if data["code"] == 404
                                                                    {
                                                                        let errorAlert = UIAlertController(title: "Внимание", message: "Переданы неверные данные: есть пустые поля", preferredStyle: .alert)
                                                                        let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                        errorAlert.addAction(errorOk)
                                                                        self.present(errorAlert, animated: true, completion: nil)
                                                                    }
                                                                    if data["code"] == 500
                                                                    {
                                                                        let errorAlert = UIAlertController(title: "Внимание", message: "Ошибка на сервере", preferredStyle: .alert)
                                                                        let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                                                                        errorAlert.addAction(errorOk)
                                                                        self.present(errorAlert, animated: true, completion: nil)
                                                                    }
                                                                })
                }
                
                let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                loginAlert.addAction(ok)
                loginAlert.addAction(cancel)
                self.present(loginAlert, animated: true, completion: nil)
            }
            let signIN = UIAlertAction(title: "Авторизация", style: .default)
            { (action) in
                let signinAlert = UIAlertController(title: "Введите данные", message: "", preferredStyle: .alert)
                for _ in 0...1{
                    signinAlert.addTextField(configurationHandler: self.toDoHandler)
                }
                signinAlert.textFields?[0].placeholder = "Логин"
                signinAlert.textFields?[1].placeholder = "Пароль"
                let ok = UIAlertAction(title: "Авторизироваться", style: .default)
                { [self] (action) in
                    let username = signinAlert.textFields?[0].text!
                    let password = signinAlert.textFields?[1].text!
                    let url = String("https://46.17.104.151:5000/probasket/authorization?type=login&username=\(username!)&pas=\(password!)")
                    sessionManager.request(url).responseJSON(completionHandler: {
                        (response) in
                        let data = JSON(response.data)
                        print (data)
                        if data["code"] == 200
                        {
                            try! userWrite.write
                            {
                                var object = User()
                                object.firstName = data["user"]["first_name"].stringValue
                                object.lastName = data["user"]["last_name"].stringValue
                                object.middleName = data["user"]["middle_name"].stringValue
                                object.api_Key = data["user"]["api_key"].stringValue
                                userRead[0].infoUser = object
                            }
                            let errorAlert = UIAlertController(title: "Поздравляю", message: "Вы успешно авторизировались", preferredStyle: .alert)
                            let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                            errorAlert.addAction(errorOk)
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                        if data["code"] == 403
                        {
                            let errorAlert = UIAlertController(title: "Внимание", message: "Неверные логин или пароль", preferredStyle: .alert)
                            let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                            errorAlert.addAction(errorOk)
                            self.present(errorAlert, animated: true, completion: nil)
                            
                        }
                        if data["code"] == 400
                        {
                            let errorAlert = UIAlertController(title: "Внимание", message: "Переданы неверные данные:\n есть пустые поля", preferredStyle: .alert)
                            let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                            errorAlert.addAction(errorOk)
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                        if data["code"] == 500
                        {
                            let errorAlert = UIAlertController(title: "Внимание", message: "Ошибка на сервере, не удалось обратиться к базе данных", preferredStyle: .alert)
                            let errorOk = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                            errorAlert.addAction(errorOk)
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                    })
                }
                let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                signinAlert.addAction(ok)
                signinAlert.addAction(cancel)
                self.present(signinAlert, animated: true, completion: nil)
            }
            alert.addAction(logIN)
            alert.addAction(signIN)
            
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            menu?.menuWidth = self.view.frame.width * 1.5 / 2
            present(menu!, animated: true, completion: nil)
           
        }
    }
    
    @IBAction func helpButton(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Help") as! Help
            self.present(nextViewController, animated:true, completion:nil)
        
    }
    
}
extension Menu: UITabBarDelegate
{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        
        if item == tabBar.items![1]
        {
            let tabBar = storyboard?.instantiateViewController(identifier: "Field")
            let alert = UIAlertController(title: "Внимание", message: "Во время игры нельзя сменить выбранные команды.\nХотите продолжить?", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "Да", style: .destructive) {(action) in
                
                if myTeamRead[0].myTeam == nil && enemysTeamRead[0].myTeam == nil
                {
                    let alertMyTeamsEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команды", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Нужно выбрать", style: .destructive, handler: nil)
                    alertMyTeamsEmpty.addAction(ok)
                    self.present(alertMyTeamsEmpty, animated: true, completion: nil)
                }
                else if myTeamRead[0].myTeam == nil
                {
                    let alertMyTeamEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команду", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Нужно выбрать", style: .destructive, handler: nil)
                    alertMyTeamEmpty.addAction(ok)
                    self.present(alertMyTeamEmpty, animated: true, completion: nil)
                }
                else if enemysTeamRead[0].myTeam == nil
                {
                    let alertEnemyTeamEmpty = UIAlertController(title: "Внимание", message: "Вы не выбрали команду противника", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Нужно выбрать", style: .destructive, handler: nil)
                    alertEnemyTeamEmpty.addAction(ok)
                    self.present(alertEnemyTeamEmpty, animated: true, completion: nil)
                }
                else
                {
                    let newVC = self.storyboard?.instantiateViewController(identifier: "Field")
                    self.navigationController?.pushViewController(newVC!, animated: true)
                }
            }
            let no = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
            alert.addAction(ok)
            alert.addAction(no)
            present(alert, animated: true, completion: nil)
            
        }
        if (item == tabBar.items![2])
        {
            let vc = storyboard?.instantiateViewController(identifier: "TeamsView")
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        if (item == tabBar.items![0])
        {
            let vc = storyboard?.instantiateViewController(identifier: "StatisticViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

extension Menu: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if toDoRead.count == 0
        {
            return 0
        }
        else
        {
            return toDoRead.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if toDoRead.count == 0
        {
            let cell = UITableViewCell()
            return cell
        }
        else
        {
            let cell = UITableViewCell()
            cell.textLabel?.numberOfLines = 0
            cell.textLabel!.text = toDoRead[toDoRead.count - indexPath.row - 1].note
            return cell
        }
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Мои заметки"
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView
        {
            headerView.textLabel?.textAlignment = .center
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if (toDoRead.count != 0)
        {
            let swipeDelete = UIContextualAction(style: .destructive, title: "Удалить")
            {
                (action, view, success) in
                try! toDoWrite.write
                {
                    toDoWrite.delete(toDoRead[toDoRead.count - 1 - indexPath.row])
                }
                tableView.reloadData()
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
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}
