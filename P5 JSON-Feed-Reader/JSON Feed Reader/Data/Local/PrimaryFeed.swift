//
//  PrimaryFeed.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 03/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import CoreData

class PrimaryFeed {
    
    static let shared = PrimaryFeed()
    
    private init() {}
    
    func insertIfDoNotExist(dataController: DataController) {
        let feed = Feed(context: dataController.viewContext)
        
        feed.version = "https://jsonfeed.org/version/1"
        feed.title = "JSON Feed"
        feed.author = "Brent Simmons and Manton Reece"
        feed.desc = "JSON Feed is a pragmatic syndication format for blogs, microblogs, and other time-based content."
        feed.favicon_url = "https://jsonfeed.org/graphics/icon.png"
        feed.feed_url = "https://jsonfeed.org/feed.json"
        
        try? dataController.viewContext.save()
    }
    
    func get(dataController: DataController) -> Feed? {
        let fetchRequest: NSFetchRequest<Feed> = Feed.fetchRequest()
        if let feeds = try? dataController.viewContext.fetch(fetchRequest) {
            if feeds.count <= 0 {
                return nil
            }
            
            return feeds[0]
        }
        
        return nil
    }
}
