//
//  addComandView.swift
//  BasketApp
//
//  Created by Daniil on 28.01.2021.
//

import UIKit
import RealmSwift
let realm = try! Realm()

class addTeamsView: UIViewController
{
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var nameTeamField: UITextField!
    @IBOutlet var numOne: UITextField!
    @IBOutlet var numTwo: UITextField!
    @IBOutlet var numThree: UITextField!
    @IBOutlet var numFour: UITextField!
    @IBOutlet var numFive: UITextField!
    @IBOutlet var numSix: UITextField!
    @IBOutlet var numSeven: UITextField!
    @IBOutlet var numEight: UITextField!
    @IBOutlet var numNine: UITextField!
    @IBOutlet var numTen: UITextField!
    @IBOutlet var numEleven: UITextField!
    @IBOutlet var numTwelve: UITextField!
    var array = [UITextField]()
    override func viewDidLoad()
    
    {
        super.viewDidLoad()
        //Зарегистрировать и запомнить нажатие на view
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Перед появлением добавить наблюдателей для клавиатуры
        registerKeyboardNotifications()
        array.append(nameTeamField)
        array.append(numOne)
        array.append(numTwo)
        array.append(numThree)
        array.append(numFour)
        array.append(numFive)
        array.append(numSix)
        array.append(numSeven)
        array.append(numEight)
        array.append(numNine)
        array.append(numTen)
        array.append(numEleven)
        array.append(numTwelve)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    @objc func didTapView(gesture: UITapGestureRecognizer)
    {
        //Убрать клавиатуру при нажатии на view
        view.endEditing(true)
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
        //
        let userInfo = notification.userInfo
        let kbSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
    }
    @objc func kbWillHide(_ notification: Notification)
    {
        
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    
    
    var emptyFlag = false
    @IBAction func addTeam(_ sender: Any)
    {
        
        for item in array
        {
            if (item.text == "")
            {
                emptyFlag = true
                
            }
        }
        if emptyFlag
        {
            let attention = UIAlertController(title: "Хмм...🧐", message: "Похоже вы что-то забыли указать🥺", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            attention.addAction(ok)
            present(attention, animated: true, completion: nil)
            emptyFlag = false
        }
        else
        {
            try! realm.write{
                let obj = MyRealObject()
                let comand = createComand(array: array)
                obj.myStruct = comand
                realm.add(obj)
            }
            let attention = UIAlertController(title: "Ура 🥳", message: "Команда добавллена", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) {(action) in goToView(VC: self, newVC: "TeamsView")}
            attention.addAction(ok)
            present(attention, animated: true, completion: nil)
        }
    }
}
