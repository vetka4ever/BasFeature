//
//  logIn.swift
//  BasketApp
//
//  Created by Даниил on 12.11.2020.
//
import UIKit
import Alamofire
import SwiftyJSON
class SignIn: UIViewController
{
    let sessionManager: Session = {
        let serverTrustPolicies: [String: ServerTrustEvaluating] = ["46.17.104.151": DisabledTrustEvaluator()]
        return Session(serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies)
        )}()
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBAction func LogButton(_ sender: UIButton)
    {
        let login = loginField.text!
        let password = passwordField.text!
        let url = String("https://46.17.104.151:5000/probasket/authorization?type=login&username=\(login)&pas=\(password)")
        sessionManager.request(url).responseJSON { response in
                let data = JSON(response.data)
                print(data["code"])
                if data["code"] == 200
                {
                    let newVC = self.storyboard?.instantiateViewController(identifier: "Menu") as! Menu
                    self.navigationController?.pushViewController(newVC, animated: true)
                }
                else if data["code"] == 403 || data["code"] == 403
                {
                    let alert = UIAlertController(title: "Внимание", message: "Неверные логин или пароль", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    let alert = UIAlertController(title: "Внимание", message: "Возникли неполадки с сервером", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Хорошо", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
    }
}

