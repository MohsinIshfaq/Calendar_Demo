//
//  AppDelegate.swift
//  Calendar_Demo
//
//  Created by Mohsin on 06/11/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var calendarController: UICalendarViewController!
    var navController: UINavigationController!

    static var delegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        calendarController = UICalendarViewController()
        navController = UINavigationController(rootViewController: calendarController)
        navController.isNavigationBarHidden = true
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

