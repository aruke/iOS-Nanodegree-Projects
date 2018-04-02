//
//  LocalRepository.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import CoreData

class LocalRepository: RepositoryProtocol {
    
    var dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func loadPosts(feed: Feed, onError: @escaping ErrorCallback, onPostsLoaded: @escaping PostsCallback) {
        if !dataController.isLoaded {
            onError(Errors.LocalDatabaseError)
            return
        }
        
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            let results = try dataController.viewContext.fetch(fetchRequest)
            print("Loaded posts from local db.")
            onPostsLoaded(results)
            return
        } catch {
            print("Fetch Error")
            onError(Errors.LocalDatabaseError)
        }
    }
    
    func loadContent(postId: String, onError: @escaping ErrorCallback, onContentLoaded: @escaping ContentCallback) {
        if !dataController.isLoaded {
            onError(Errors.LocalDatabaseError)
            return
        }
    }
}
