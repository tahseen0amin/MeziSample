//
//  DownloadImageService.swift
//  MeziSample
//
//  Created by Taseen Amin on 22/03/2017.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit

class DownloadImageService {
    
    class func downloadImage(withUrl url:URL, completionHandler:((UIImage)->Void)?) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            completionHandler?(image)
            }.resume()
    }
}
