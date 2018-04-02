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
        "accuracy": 6,
        "per_page": 30
    ]

    static let shared = FlickrApiHandler()

    private init() {}

    func loadPhotos(context: NSManagedObjectContext, place: Place, completion: @escaping (Errors?) -> Void) {

        let requestUrl = generateUrl(place.latitude, place.longitude)
        let request = URLRequest(url: requestUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in

            if error != nil {
                print("Error in flickr request \(error.debugDescription)")
                // Handle error
                completion(Errors.NetworkError)
                return
            }

            let responseDict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            if responseDict["stat"] as? String != "ok" || responseDict["photos"] == nil {
                // Some server error
                print("Error: No photos or status in response")
                completion(Errors.ServerError)
                return
            }

            // Get Photos Array
            let results = responseDict["photos"] as! NSDictionary
            let photoArray = results["photo"] as! [NSDictionary]
            print("\(photoArray.count) Photos downloaded")
            place.photos = NSSet()
            for photoDictionary in photoArray {
                let photo = Photo(context: context)
                photo.setFrom(photoDictionary)
                place.addToPhotos(photo)
            }

            // Save context, return to caller
            if context.hasChanges {
                do {
                    // Completion with success
                    try context.save()
                    print("Saved Images to local database")
                    completion(nil)
                } catch let dbError {
                    // Completion with error
                    print("Local database error \(dbError.localizedDescription)")
                    completion(Errors.DatabaseError)
                }
                return
            } else {
                // No changes in data, empty response
                completion(Errors.ServerError)
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
