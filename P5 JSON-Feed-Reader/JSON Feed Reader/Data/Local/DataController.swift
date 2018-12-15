//
//  DataController.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistanceContainer: NSPersistentContainer
    var isLoaded: Bool!
    
    init(modelName: String = "JSON_Feed_Reader") {
        self.persistanceContainer = NSPersistentContainer(name: modelName)
        isLoaded = false
    }
    
    var viewContext: NSManagedObjectContext {
        return self.persistanceContainer.viewContext
    }
    
    func load(completion: (() -> Void)? = nil) {
        self.persistanceContainer.loadPersistentStores(completionHandler: {
            storeDescription, error in
            guard error == nil else {
                self.isLoaded = false
                print("Persistenace Store not Loaded!!!")
                fatalError(error!.localizedDescription)
            }

            print("Persistance Store loaded successfully")
            self.isLoaded = true
            PrimaryFeed.shared.insertIfDoNotExist(dataController: self)
            completion?()
        })
    }
}
