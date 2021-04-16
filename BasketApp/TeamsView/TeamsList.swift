//
//  TeamsList.swift
//  BasketApp
//
//  Created by Daniil on 30.01.2021.
//
import RealmSwift
import Foundation

//Запись в БД
var realm = try! Realm()
// Доступ к БД с командами
var dataBase: Results<MyRealObject> = realm.objects(MyRealObject.self)
// Запись команды
var myTeamWrite = try! Realm()
// Доступ к БД с выбранной командой
var myTeamRead : Results<MyTeam> = myTeamWrite.objects(MyTeam.self)
// Запись команды противника
var enemysTeamWrite = try! Realm()
// Доступ к БД с выбранной командой противника
var enemysTeamRead : Results<EnemyTeam> = enemysTeamWrite.objects(EnemyTeam.self)
//Запись статистики
var statWrite = try! Realm()
//Доступ к статистике
var statRead : Results<TeamStatic> = statWrite.objects(TeamStatic.self)
//Запись в Todo
var toDoWrite = try! Realm()
//Чтение из Todo
var toDoRead : Results<Todo> = toDoWrite.objects(Todo.self)
// Запись информации о пользователе
var userWrite = try! Realm()
// Чтение информации о пользователе
var userRead : Results<Users> = userWrite.objects((Users.self))
