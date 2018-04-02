//
//  FlickrApiHandler.swift
//  Virtual Tourist
//
//  Created by Rajanikant Deshmukh on 28/03/18.
//  Copyright © 2018 Rajanikant Deshmukh. All rights reserved.
//

import Foundation
import CoreData

class FlickrApiHandler {
    
    let BASE_URL = "https://api.flickr.com/services/rest"
    var PARAMS: Dictionary<String, Any> = [
        "api_key": "80bb3d0f094ea7d9dd26d3b419f4f7fe", /*Enter API Key here*/
        "method" : "flickr.photos.search",
        "format" : "json",
        "extras": "url_m",
        "nojsoncallback" : 1,
        "accuracy": 6
    ]
    
    static let shared = FlickrApiHandler()
    
    private init() {}
    
    func loadPhotos(context: NSManagedObjectContext, latitude: Double, longitude: Double, completion: @escaping () -> Void) {
        let requestUrl = generateUrl(latitude, longitude)
        let request = URLRequest(url: requestUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                print("Error in flickr request \(error.debugDescription)")
                // TODO: Handle error
                completion()
                return
            }
            
            let responseDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            if responseDict["stat"] as? String != "ok" || responseDict["photos"] == nil {
                // TODO: Some server error
                print("Error: No photos or status in response")
                completion()
                return
            }
            
            // Get Photos Array
            let results = responseDict["photos"] as! NSDictionary
            let photoArray = results["photo"] as! [NSDictionary]
            print("\(photoArray.count) Photos downloaded")
            for photoDictionary in photoArray {
                let photo = Photo(context: context)
                photo.setFrom(photoDictionary)
            }
            
            // Save context, return to caller
            if context.hasChanges {
                do {
                    // Completion with success
                    try context.save()
                    print("Saved Images to local database")
                    completion()
                } catch let dbError {
                    // TODO: Completion with error
                    print("Local database error \(dbError.localizedDescription)")
                    completion()
                }
                return
            } else {
                // No changes in data, empty response
                completion()
                return
            }
        })
        
        task.resume()
    }
    
    private func generateUrl(_ latitude: Double, _ longitude: Double) -> URL {
        PARAMS.updateValue(latitude, forKey: "lat")
        PARAMS.updateValue(longitude, forKey: "lon")
        
        var queryItems = [URLQueryItem]()
        for item in PARAMS {
            queryItems.append(URLQueryItem(name: item.key, value: String(describing: item.value)))
            print(item)
        }
        let urlComponent = NSURLComponents(string: BASE_URL)!
        urlComponent.queryItems = queryItems
        
        return urlComponent.url!
    }
}
