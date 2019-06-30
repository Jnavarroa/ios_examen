//
//  AppDelegate.swift
//  IOS_Examen
//
//  Created by Martin Galvan on 6/27/19.
//  Copyright © 2019 Jaime Navarro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let save = SaveAndGetData()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let ancho : String = "\(UIScreen.main.bounds.size.width)"
        save.saveData(ancho: ancho)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let main = MainController()
        self.window!.rootViewController = main
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

