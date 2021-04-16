//
//  Funcs.swift
//  BasketApp
//
//  Created by Daniil on 27.01.2021.
//
import UIKit
import Foundation
import SwiftyJSON
/*
 goToView - функция для смены экранов;
 VC - нынешний экран;
 newVC - новый экран
 */
func goToView(VC: UIViewController, newVC : String)
{
    
    let storyboard: UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
    let nextVC = storyboard.instantiateViewController(identifier: newVC) as UIViewController
    nextVC.modalPresentationStyle = .fullScreen
    VC.present(nextVC, animated: true, completion: nil)
}


///pixel - функция для определения цвета по координатам
/// - Parameters:
///   - image: Изображение с UIImageView
///   - x: координата нажатия по x
///   - y: координата нажатия по y
/// - Returns: возвращается цвет, по которому определяется необходимая картинка(смотреть Assets)
func pixel(image: UIImage, x: Int, y: Int) -> UIColor
{
    let width = image.size.width
    guard let pointer = image.cgImage?.dataProvider?.data,
          let point = CFDataGetBytePtr(pointer) else{
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }
    let byterPerPixel = 4
    let offset = (x + y * Int(width)) * byterPerPixel
    let red = CGFloat(point[offset])
    let green = CGFloat(point[offset + 1])
    let blue =  CGFloat(point[offset + 2])
    let alpha =  CGFloat(point[offset + 3])
    let color = UIColor (red: red, green: green, blue: blue, alpha: alpha)
    return color
}
// createComand - функция для создание комнды
func createComand(array: [UITextField]) -> Comand
{
    var comand = Comand()
    comand.name = array[0].text!
    comand.players[0].numeric = array[1].text!
    comand.players[1].numeric = array[2].text!
    comand.players[2].numeric = array[3].text!
    comand.players[3].numeric = array[4].text!
    comand.players[4].numeric = array[5].text!
    comand.players[5].numeric = array[6].text!
    comand.players[6].numeric = array[7].text!
    comand.players[7].numeric = array[8].text!
    comand.players[8].numeric = array[9].text!
    comand.players[9].numeric = array[10].text!
    comand.players[10].numeric = array[11].text!
    comand.players[11].numeric = array[12].text!
    return comand
}

/// // numberZone - функция для выбора картинки
/// - Parameters:
///   - color: цвет полученный из pixel
///   - x: координата нажатия по x
///   - y: координата нажатия по y
/// - Returns: возвращает название будущей картинки
func numberZone(color: UIColor, x: Int, y: Int) -> String
{
    switch color
    {
    case UIColor(red: 255, green: 168, blue: 89, alpha: 1):
        return "1"
        
    case UIColor(red: 255, green: 217, blue: 179, alpha: 1):
        return "2"
        
    case UIColor(red: 255, green: 169, blue: 91, alpha: 1):
        if (y <= 136)
        {
            return "9"
        }
        else
        {
            return "3"
        }
        
    case UIColor(red: 255, green: 216, blue: 181, alpha: 1):
        return "4"
        
    case UIColor(red: 255, green: 166, blue: 89, alpha: 1):
        return "5"
        
    case UIColor(red: 255, green: 197, blue: 147, alpha: 1):
        return "6"
        
    case UIColor(red: 254 , green: 168, blue: 90, alpha: 1):
        return "7"
        
    case UIColor(red: 253, green: 216, blue: 179, alpha: 1):
        return "8"
        
    //    case UIColor(red: 255, green: 169, blue: 91, alpha: 1):
    //        return "9"
    
    case UIColor(red: 253, green: 198, blue: 147, alpha: 1):
        return "10"
        
        
    case UIColor(red: 255, green: 217, blue: 183, alpha: 1):
        return "11"
        
    case UIColor(red: 255, green: 198, blue: 145, alpha: 1):
        return "12"
        
    case UIColor(red: 255, green: 218, blue: 181, alpha: 1):
        return "13"
        
    case UIColor(red: 253, green: 169, blue: 89, alpha: 1):
        return "14"
        
    default:
        return "Field"
    }
}



func currentDate() -> String
{
    var date = ""
    let calendar = Calendar.current
    let day = calendar.component(.day, from: Date())
    let month = calendar.component(.month, from: Date())
    let year = calendar.component(.year, from: Date())
    date = "\(day).\(calendar.monthSymbols[month - 1]).\(year)"
    return date
}
func percent(winShot: Int, allShot: Int) -> String
{
    if (winShot == 0 || allShot == 0)
    {
        return "0.00%";
    }
    else
    {
        let stat = Float(winShot) / Float(allShot) * 100
        let res = NSString(format: "%.2f", stat) as String + "%" as String
        
        return res
    }
}
func StaticInTime(numTime: String, players: [Player], oneTime: Bool) -> [[Int]]
{
    var result = [[Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()], [Int(),Int()] ]
    if (oneTime)
    {
        switch numTime {
        case "1":
            for player in players
            {
                for i in 0...13
                {
                    result[i][0] += player.firstTime[i][0]
                    result[i][1] += player.firstTime[i][1]
                }
            }
            break
        case "2":
            for player in players
            {
                for i in 0...13
                {
                    result[i][0] += player.secondTime[i][0]
                    result[i][1] += player.secondTime[i][1]
                }
            }
            break
        case "3":
            for player in players
            {
                for i in 0...13
                {
                    result[i][0] += player.thirdTime[i][0]
                    result[i][1] += player.thirdTime[i][1]
                }
            }
            break
        default:
            for player in players
            {
                for i in 0...13
                {
                    result[i][0] += player.fourthTime[i][0]
                    result[i][1] += player.fourthTime[i][1]
                }
            }
            break
        }
    }
    else
    {
        for player in players
        {
            for i in 0...13
            {
                result[i][0] += player.firstTime[i][0]
                result[i][1] += player.firstTime[i][1]
                result[i][0] += player.secondTime[i][0]
                result[i][1] += player.secondTime[i][1]
                result[i][0] += player.thirdTime[i][0]
                result[i][1] += player.thirdTime[i][1]
                result[i][0] += player.fourthTime[i][0]
                result[i][1] += player.fourthTime[i][1]
            }
        }
        
    }
    return result
}
func writeUser(data : JSON, object: Users) -> Users
{
    
    return object
}
