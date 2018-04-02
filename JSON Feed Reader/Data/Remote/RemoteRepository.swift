//
//  RemoteRepository.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class RemoteRepository: RepositoryProtocol {
    
    func loadPosts(feed: Feed, onError: @escaping ErrorCallback, onPostsLoaded: @escaping PostsCallback) {
        // TODO: Implement
        onError(Errors.UnknownError)
    }
    
    func loadContent(postId: String, onError: @escaping ErrorCallback, onContentLoaded: @escaping ContentCallback) {
        // TODO: Implement
        onError(Errors.UnknownError)
    }
}
