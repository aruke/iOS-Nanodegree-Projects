//
//  DataRepository.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class DataRepository: RepositoryProtocol {
    
    private let localRepository: LocalRepository
    private let remoteRepository: RemoteRepository
    
    init(local: LocalRepository, remote: RemoteRepository) {
        self.localRepository = local
        self.remoteRepository = remote
    }
    
    func loadPosts(feed: Feed, onError: @escaping ErrorCallback, onPostsLoaded: @escaping PostsCallback) {
        self.localRepository.loadPosts(feed: feed, onError: {
            error in
            // Load content from remote
            self.remoteRepository.loadPosts(feed: feed, onError: {
                error in
                DispatchQueue.main.async { onError(error) }
            }, onPostsLoaded: {
                posts in
                DispatchQueue.main.async { onPostsLoaded(posts) }
            })
        }, onPostsLoaded: {
            posts in
            DispatchQueue.main.async { onPostsLoaded(posts) }
        })
    }
    
    func loadContent(postId: String, onError: @escaping ErrorCallback, onContentLoaded: @escaping ContentCallback) {
        self.localRepository.loadContent(postId: postId, onError: {
            error in
            // Load content from remote
            self.remoteRepository.loadContent(postId: postId, onError: {
                error in
                DispatchQueue.main.async { onError(error) }
                
            }, onContentLoaded: {
                content in
                DispatchQueue.main.async { onContentLoaded(content) }
            })
        }, onContentLoaded: {
            content in
            DispatchQueue.main.async { onContentLoaded(content) }
        })
    }
}
