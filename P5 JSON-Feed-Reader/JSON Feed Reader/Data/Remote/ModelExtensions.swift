//
//  ModelExtensions.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 03/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import JSONFeed

extension Feed {
    
    func setFrom(_ jsonFeed: JSONFeed) {
        self.version = String(describing: jsonFeed.version)
        self.title = jsonFeed.title
        self.author = jsonFeed.author?.name
        self.desc = jsonFeed.feedDescription
        self.feed_url = String(describing: jsonFeed.url)
        self.favicon_url = String(describing: jsonFeed.favicon)
    }
}

extension Post {
    
    func setFrom(_ jsonFeedItem: JSONFeedItem) {
        self.id = jsonFeedItem.id
        self.title = jsonFeedItem.title
        self.url = String(describing: jsonFeedItem.url)
        self.content_text = jsonFeedItem.contentText
        self.content_html = jsonFeedItem.contentHtml
        self.date_published = jsonFeedItem.date
    }
    
}
