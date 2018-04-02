//
//  RepositoryProtocol.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {

    typealias ErrorCallback = ((Errors) -> Void)
    
    typealias PostsCallback = (([Post]) -> Void)
    typealias PostCallback = ((Post) -> Void)
    typealias ContentCallback = ((String) -> Void)
    
    func loadPosts(feed: Feed, onError: ErrorCallback, onPostsLoaded: PostsCallback)
    
    func loadContent(postId: String, onError: ErrorCallback, onContentLoaded: ContentCallback)
}
