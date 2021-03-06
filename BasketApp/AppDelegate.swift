//
//  AppDelegate.swift
//  BasketApp
//
//  Created by Даниил on 09.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

// comment for commit56

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if myTeamRead.count == 0
        {
            try! myTeamWrite.write
            {
                let obj = MyTeam()
                obj.myTeam?.name = "myTeam"
                myTeamWrite.add(obj)
            }
        }
        if enemysTeamRead.count == 0
        {
            try! enemysTeamWrite.write
            {
                let obj = EnemyTeam()
                obj.myTeam?.name = "enemyTeam"
                enemysTeamWrite.add(obj)
            }
        }
        if (userRead.count == 0)
        {
            try! userWrite.write
            {
                let object = Users()
                userWrite.add(object)
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

