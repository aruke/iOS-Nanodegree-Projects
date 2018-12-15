//
//  DataController.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistanceContainer: NSPersistentContainer
    
    init(modelName: String = "Virtual_Tourist") {
        self.persistanceContainer = NSPersistentContainer(name: modelName)
    }
    
    var viewContext: NSManagedObjectContext {
        return self.persistanceContainer.viewContext
    }
    
    func load(completion: (() -> Void)? = nil) {
        self.persistanceContainer.loadPersistentStores(completionHandler: {
            storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            
            completion?()
        })
    }
}
