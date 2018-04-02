//
//  LocalRepository.swift
//  JSON Feed Reader
//
//  Created by Rajanikant Deshmukh on 02/04/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation

class LocalRepository: RepositoryProtocol {
    
    func loadPosts(feed: Feed, onError: (Errors) -> Void, onPostsLoaded: ([Post]) -> Void) {
        // TODO: Implement
    }
    
    func loadContent(postId: String, onError: (Errors) -> Void, onContentLoaded: (String) -> Void) {
        // TODO: Implement
    }
}
