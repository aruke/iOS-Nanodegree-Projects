//
//  AppDelegate.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 22/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let dataController = DataController()
    var coreDataEnabled = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        dataController.load(completion: {
            print("DataController Loaded successfullys")
            self.coreDataEnabled = true
        })
        
        // Inject data controller into first ViewController
        let navigationController = window?.rootViewController as! UINavigationController
        let mapViewController = navigationController.topViewController as! TravelMapViewController
        mapViewController.dataController = self.dataController
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = dataController.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

