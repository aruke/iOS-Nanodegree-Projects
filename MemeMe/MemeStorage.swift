//
//  MemeStorage.swift
//  MemeMe
//
//  Created by Rajanikant Deshmukh on 16/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import UIKit

class MemeStorage: NSObject {
    
    private static var memes = [MemeObject]()
    
    private override init() {
    }
    
    static func getMemes() -> [MemeObject] {
        return memes
    }
    
    static func addMeme(_ meme: MemeObject) {
        memes.append(meme)
    }
    
    static func get(_ position: Int) -> MemeObject {
        return memes[position]
    }
    
    static func getCount() -> Int {
        return memes.count
    }
}
