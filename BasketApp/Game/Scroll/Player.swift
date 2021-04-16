//
//  Player.swift
//  BasketApp
//
//  Created by Daniil on 11.12.2020.
//
import UIKit
import Foundation
class Player {
    
    struct Player {
        var numeric = 0
        var firstZone = [0,0]
        var secondZone = [0,0]
        var thirdZone = [0,0]
        var fourthZone = [0,0]
        var fifthZone = [0,0]
        var sixthZone = [0,0]
        var seventhZone = [0,0]
        var eighthZone = [0,0]
        var ninethZone = [0,0]
        var tenthZone = [0,0]
        var eleventhZone = [0,0]
        var twelvethZone = [0,0]
        var threteenthZone = [0,0]
        var fourteenthZone = [0,0]
        
    }
    
    
    //функция для создания структуры
    func setUp() {
        let pl1 = Player(numeric: 23, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl2 = Player(numeric: 62, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl3 = Player(numeric: 81, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl4 = Player(numeric: 94, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl5 = Player(numeric: 59, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl6 = Player(numeric: 01, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl7 = Player(numeric: 11, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        let pl8 = Player(numeric: 78, firstZone: [0,0], secondZone: [0,0], thirdZone: [0,0], fourthZone: [0,0], fifthZone: [0,0], sixthZone: [0,0], seventhZone: [0,0], eighthZone: [0,0], ninethZone: [0,0], tenthZone: [0,0], eleventhZone: [0,0], twelvethZone: [0,0], threteenthZone: [0,0], fourteenthZone: [0,0])
        self.team = [pl1,pl2,pl3,pl4,pl5,pl6,pl7,pl8]
    }
    
    var team = [Player]()
//    init() {
//        setUp()
//    }
}
