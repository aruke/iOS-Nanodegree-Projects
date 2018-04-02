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
        self.localRepository.loadPosts(feed: feed, onError: {error in
            // Load content from remote
            self.remoteRepository.loadPosts(feed: feed, onError: onError
                , onPostsLoaded: { posts in
                onPostsLoaded(posts)
            })
        }, onPostsLoaded: {posts in
            onPostsLoaded(posts)
        })
    }
    
    func loadContent(postId: String, onError: @escaping ErrorCallback, onContentLoaded: @escaping ContentCallback) {
        self.localRepository.loadContent(postId: postId, onError: {error in
            // Load content from remote
            self.remoteRepository.loadContent(postId: postId, onError: onError, onContentLoaded: { content in
                onContentLoaded(content)
            })
        }, onContentLoaded: {content in
            onContentLoaded(content)
        })
    }
    
    func getPrimaryFeed() -> Feed {
        return Feed()
    }
}
