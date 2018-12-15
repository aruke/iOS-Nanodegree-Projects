//
//  RemoteRepository.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import JSONFeed

class RemoteRepository: RepositoryProtocol {
    
    var dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func loadPosts(feed: Feed, onError: @escaping ErrorCallback, onPostsLoaded: @escaping PostsCallback) {
        let feedUrl = URL(string: feed.feed_url!)
        let request = URLRequest(url: feedUrl!)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                self.handleError(error, onError: onError)
                return
            }
            
            do {
                let jsonFeed = try JSONFeed(data: data!)
                var posts = [Post]()
                let jsonFeedItems = jsonFeed.items
                for jsonFeedItem in jsonFeedItems {
                    let post = Post(context: self.dataController.viewContext)
                    post.setFrom(jsonFeedItem)
                    posts.append(post)
                }
                onPostsLoaded(posts)
            } catch {
                self.handleError(error, onError: onError)
            }
        }
        task.resume()
    }
    
    func loadContent(postId: String, onError: @escaping ErrorCallback, onContentLoaded: @escaping ContentCallback) {
        // No need to implement in Remote
        onError(Errors.UnknownError)
    }
    
    private func handleError(_ error: Error!, onError: @escaping ErrorCallback) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                onError(Errors.NetworkError)
                return
            default:
                onError(Errors.ServerError)
                return
            }
        }
        onError(Errors.ServerError)
    }
}
