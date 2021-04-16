//
//  TeamsView.swift
//  BasketApp
//
//  Created by Daniil on 27.01.2021.
//
import RealmSwift
import UIKit

class TeamsView: UIViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    //Присваивание информации и делегата tableView от TeamsView
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    let idCell = "cell"
    //    // MARK: Вернуться в меню
    //    @IBAction func goToMenu(_ sender: Any)
    //    {
    //        goToView(VC: self, newVC: "Menu")
    //    }
    // MARK: Добавить команду
    @IBAction func goToAddView(_ sender: Any)
    {
        //        let SB = UIStoryboard(name: "Main", bundle: nil)
        //        let VC = SB.instantiateViewController(withIdentifier: "addView") as UIViewController
        //        self.present(VC, animated: true, completion: nil)
        let newVC = storyboard?.instantiateViewController(identifier: "addView")
        self.navigationController?.pushViewController(newVC!, animated: true)
    }
    // MARK: Вывод на консоль количества команд в БД
    @IBAction func seeNum(_ sender: Any) {
        for item in dataBase[0].myStruct!.players
        {
            if item.numeric == ""
            {
                print("Не правильный номер")
            }
            else
            {
                print(item.numeric)
            }
        }
    }
    // MARK: Удалить все команды
    @IBAction func deleteTeams(_ sender: Any)
    {
        //Предупредить об удалении
        let alert = UIAlertController(title: "Внимание", message: "Все команды будут удалены. ", preferredStyle: .alert)
        //Создать кнопку согласия и удалить команды из бд
        let ok = UIAlertAction(title: "Да", style: .destructive)
        {
            (action) in
            //Удалить команды из БД
            try! realm.write
            {
                realm.delete(dataBase)
            }
            // Удалить выбранную команду
            try! myTeamWrite.write
            {
                myTeamRead[0].myTeam = nil
            }
            // Удалить команду противника
            try! enemysTeamWrite.write
            {
                enemysTeamRead[0].myTeam = nil
            }
            print("Количество команд:",dataBase.count)
            print("Моя команда:", myTeamRead.count)
            print("Команда противника:", enemysTeamRead.count, "\n")
            self.tableView.reloadData()
        }
        
        //Создать кнопку отказа
        let no = UIAlertAction(title: "Нет", style: .default, handler: nil)
        //Добавить кнопки в Alert
        alert.addAction(ok)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    // MARK: Вывести команды
    @IBAction func seeItems(_ sender: Any)
    {
        print("Количество команд:",dataBase.count)
        for item in dataBase
        {
            print("\(dataBase.index(of: item)! + 1))",item.myStruct!.name)
            
        }
        print("Моя команда:", myTeamRead.count)
        print("Команда противника:", enemysTeamRead.count, "\n")
    }
    // MARK: Представление tableView
    @IBOutlet var tableView: UITableView!
    /*
     Обновить tableView после добавления команды
     */
}

extension TeamsView: UITableViewDelegate, UITableViewDataSource
{
    //MARK: Задать количество секций
    /*
     
     1 - выбранная команда
     2 - команда противника
     3- все команды
     */
    func numberOfSections(in tableView: UITableView) -> Int
    {
        3
    }
    // MARK: Задать количество ячеек в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0 || section == 1)
        {
            return 1
        }
        else
        {
            if dataBase.count == 0
            {
                return 1
            }
            else {
                return dataBase.count
            }
        }
        
    }
    // MARK: Задать высоту заголовка
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        30
    }
    // MARK: Создать ячейку
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell)
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: idCell)
        }
        //Настроить title для выбранной команды
        if indexPath.section == 0
        {
            if myTeamRead.count == 0
            {
                cell?.textLabel?.text = ""
            }
            else
            {
                cell?.textLabel?.text = myTeamRead[0].myTeam?.name
            }
        }
        //Настроить title для команды противника
        if indexPath.section == 1
        {
            if enemysTeamRead.count == 0
            {
                cell?.textLabel?.text = ""
            }
            else
            {
                cell?.textLabel?.text = enemysTeamRead[0].myTeam?.name
            }
        }
        //Настроить title для всех команд
        if indexPath.section == 2
        {
            if dataBase.count != 0
            {
                cell?.textLabel?.text = dataBase[dataBase.count - 1 - indexPath.row].myStruct?.name
            }
            else
            {
                cell?.textLabel?.text = ""
            }
        }
        return cell!
    }
    // MARK: Задать заголовк
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            return "My team"
        }
        else if section == 1
        {
            return "Enemy's team"
        }
        else
        {
            return "All teams"
        }
    }
    // MARK: Свайпы для выбора команд
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //отсчет секций с нуля 😃
        if indexPath.section == 2 && dataBase.count != 0
        {
            let swipeAddMyTeam = UIContextualAction(style: .normal, title: "Моя команда") {
                action, view, success in
                // Добавить прежупреждение если команда выбрана как противник
                if dataBase[dataBase.count - 1 - indexPath.row].myStruct?.name == enemysTeamRead[0].myTeam?.name
                {
                    let alert = UIAlertController(title: "Внимание", message:"Данная команда уже выбрана в качестве противника" , preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                // Добавить прежупреждение если команда выбрана как собственная
                else if dataBase[dataBase.count - 1 - indexPath.row].myStruct?.name  == myTeamRead[0].myTeam?.name
                {
                    let alert = UIAlertController(title: "Внимание", message: "Данная команда уже вами выбрана", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                //Записать команду как собственную
                else
                {
                    try! myTeamWrite.write
                    {
                        myTeamRead[0].myTeam = dataBase[dataBase.count - 1 - indexPath.row].myStruct
                    }
                    tableView.reloadData()
                }
            }
            swipeAddMyTeam.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            
            let swipeAddEnemysTeam = UIContextualAction(style: .normal, title: "Команда противника")
            {
                (acrion, view, success) in print("Команда противника")
                // Добавить прежупреждение если команда выбрана, как собсвенная
                if dataBase[dataBase.count - 1 - indexPath.row].myStruct?.name == myTeamRead[0].myTeam?.name
                {
                    let alert = UIAlertController(title: "Внимание", message: "Данная команда уже вами выбрана", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                // Добавить прежупреждение если команда выбрана, как противник
                else if dataBase[dataBase.count - 1 - indexPath.row].myStruct?.name  == enemysTeamRead[0].myTeam?.name
                {
                    let alert = UIAlertController(title: "Внимание", message: "Данная команда уже выбрана в качестве противника", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                //Записать команду
                else
                {
                    try! enemysTeamWrite.write
                    {
                        enemysTeamRead[0].myTeam = dataBase[dataBase.count - 1 - indexPath.row].myStruct
                    }
                    tableView.reloadData()
                }
            }
            swipeAddEnemysTeam.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            //Добавить свайпы
            let swipe = UISwipeActionsConfiguration (actions: [swipeAddMyTeam,swipeAddEnemysTeam])
            //Отключить длинный свайп
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }
        else
        {
            return nil
        }
    }
    // MARK: Переход для изменения команды
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //        let VC = UIStoryboard(name: "Main", bundle: nil)
        //        let nextVC = VC.instantiateViewController(identifier: "seePlayerView")
        //        self.present(nextVC, animated: true, completion: nil)
        if (dataBase.count > 0)
        {
            let newVC = self.storyboard?.instantiateViewController(identifier: "seePlayerView") as! seePlayerView
            self.navigationController?.pushViewController(newVC, animated: true)
            newVC.itemInDataBase = dataBase.count - 1 - indexPath.row
            tableView.cellForRow(at: indexPath)?.isSelected = false
        }
    }
    // MARK: Свайпы для удаления команд
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        //Добавить свайп для удаления выбранной команды
        if indexPath.section == 0 && myTeamRead.count != 0
        {
            let swipeDelete = UIContextualAction(style: .destructive, title: "Удалить")
            {
                (action, view, success) in
                try! myTeamWrite.write
                {
                    myTeamRead[0].myTeam = nil
                }
                tableView.reloadData()
            }
            let swipe = UISwipeActionsConfiguration(actions: [swipeDelete])
            //Отключить длинный свайп
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }
        //Добавить свайп для удаления команды противника
        if indexPath.section == 1 && dataBase.count != 0
        {
            let swipeDelete = UIContextualAction(style: .destructive, title: "Удалить")
            {
                (action, view, success) in
                try! enemysTeamWrite.write
                {
                    enemysTeamRead[0].myTeam = nil
                }
                tableView.reloadData()
            }
            let swipe = UISwipeActionsConfiguration(actions: [swipeDelete])
            //Отключить длинный свайп
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }
        //Добавить свайп для удаления команды из БД
        if indexPath.section == 2 && dataBase.count != 0
        {
            let id = dataBase.count - indexPath.row - 1
            let swipeDeleteTeam = UIContextualAction(style: .destructive, title: "Удалить")
            {
                (action, view, success) in
                //Создать Alert
                let agree = UIAlertController(title: "Внимание", message:"Вы уверены, что хотите удалить команду?" , preferredStyle: .alert)
                // Создать кнопку для Alert
                let ok = UIAlertAction(title: "Да", style: .destructive)
                {
                   
                    (action) in
                    
                    try! myTeamWrite.write{
                        //Удалить команду, если она выбрана в качестве собственной
                        if dataBase[id].myStruct?.name == myTeamRead[0].myTeam?.name
                        {
                            myTeamRead[0].myTeam = nil
                        }
                        //Удалить команду, если она выбрана в качестве противника
                        if dataBase[id].myStruct?.name == enemysTeamRead[0].myTeam?.name
                        {
                            enemysTeamRead[0].myTeam = nil
                        }
                    }
                    //Удалить команду
                    try! realm.write
                    {
                        realm.delete(dataBase[id])
                    }
                    //Обновить tableView
                    self.tableView.reloadData()
                }
                // Создать кнопку для Alert
                let no = UIAlertAction(title: "Нет", style: .default, handler: nil)
                //Добавить кнопки в Alert
                agree.addAction(ok)
                agree.addAction(no)
                self.present(agree, animated: true, completion: nil)
            }
            let swipe = UISwipeActionsConfiguration(actions: [swipeDeleteTeam])
            //Отключить длинные свайпы
            swipe.performsFirstActionWithFullSwipe = false
            return swipe
        }
        
        else
        {
            return nil
        }
    }
}
