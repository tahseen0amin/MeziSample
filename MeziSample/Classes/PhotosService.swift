//
//  FKPhotoRequest.swift
//  MeziSample
//
//  Created by Taseen Amin on 21/03/2017.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit

class PhotoService {
    class func downloadPhotoData(completion:(([Photo])->Void)?){
        var req = URLRequest.init(url: URL.init(string: "https://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=d98f34e2210534e37332a2bb0ab18887&format=json&extras=url_n&nojsoncallback=1")!)
        req.httpMethod = "GET"
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            do {
                let jsonObj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                DispatchQueue.main.async {
                    completion?(parseData(json: jsonObj))
                }
            } catch _ {
                print("Something W")
            }
        }.resume()
    }
    
    private class func parseData(json:Any) -> [Photo]{
        if json is [String:Any] {
            if let photos = (json as! [String:Any])["photos"] as? [String:AnyObject] {
                if let array = photos["photo"] as? [Any]{
                    var result:[Photo] = []
                    for v in array {
                        let photo = Photo(dictionary: v as! [String : AnyObject])
                        result.append(photo)
                    }
                    return result
                }
            }
        }
        return []
    }
}












