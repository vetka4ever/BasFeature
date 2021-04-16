//
//  ComandStruct.swift
//  BasketApp
//
//  Created by Daniil on 28.01.2021.
//

import Foundation
import UIKit
import RealmSwift
/*
 MARK: Структура для хранения информации об игроке
 numeric - номер игрока
 firstTime, secondTime, thirdTime ,fourthTime - массивы для сохранения попаданий и бросков в соответствующих зонах.
 [.....[попадания/броски].....]
 */
struct Player: Codable
{
    var numeric = String();
    var firstTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
    var secondTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
    var thirdTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
    var fourthTime = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0] ]
    
}
/*
 MARK: Структура для хранения информации о команде
 name - название команды
 players - игроки команды
 */
struct Comand: Codable
{
    var name = String()
    var players : [Player] = [Player(),Player(),Player(),Player(),Player(),Player(),Player(),Player(),Player(),Player(),Player(),Player()]
}
/*
 MARK: Структура для хранения всех команд
 */
struct AllComand : Codable
{
    var allCommand = [Comand]()
}
/*
 MARK: Realm объект для локального хранения команд
 */
class MyRealObject : Object {
    
    @objc dynamic var structData:Data? = nil
    
    var myStruct : Comand? {
        get {
            if let data = structData {
                return try? JSONDecoder().decode(Comand.self, from: data)
            }
            return nil
        }
        set {
            structData = try? JSONEncoder().encode(newValue)
        }
    }
}
/*
 MARK: Realm объект для локального хранения выбранной команды
 */
class MyTeam : Object
{
    @objc dynamic var teamData : Data? = nil
    var myTeam : Comand?
    {
        get
        {
            if let data = teamData
            {
                return try? JSONDecoder().decode(Comand.self, from: data)
            }
            else
            {
                return nil
            }
        }
        set
        {
            teamData = try? JSONEncoder().encode(newValue)
        }
    }
}
/*
 MARK: Realm объект для локального хранения команды противника
 */
class EnemyTeam : Object
{
    @objc dynamic var teamData : Data? = nil
    var myTeam : Comand?
    {
        get
        {
            if let data = teamData
            {
                return try? JSONDecoder().decode(Comand.self, from: data)
            }
            else
            {
                return nil
            }
        }
        set
        {
            teamData = try? JSONEncoder().encode(newValue)
        }
    }
}
struct GameStatic : Codable
{
    var currentDate = ""
    var myTeam = Comand()
    var enemyTeam = Comand()
}
class TeamStatic : Object
{
    @objc dynamic var teamData : Data? = nil
    var stat : GameStatic?
    {
        get
        {
            if let data = teamData
            {
                return try? JSONDecoder().decode(GameStatic.self, from: data)
            }
            else
            {
                return nil
            }
        }
        set
        {
            teamData = try? JSONEncoder().encode(newValue)
        }
    }
}

class Todo : Object
{
    @objc dynamic var note = ""
}

struct User : Codable
{
    var firstName = ""
    var middleName = ""
    var lastName = ""
    var api_Key = ""
}
class Users : Object
{
    @objc dynamic var userData : Data? = nil
    var infoUser : User?
    {
        get
        {
            if let data = userData
            {
                return try? JSONDecoder().decode(User.self, from: data)
            }
            else
            {
                return nil
            }
        }
        set
        {
            userData = try? JSONEncoder().encode(newValue)
        }
    }
}
