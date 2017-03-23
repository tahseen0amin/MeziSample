//
//  Photo.swift
//  MeziSample
//
//  Created by Taseen Amin on 21/03/2017.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit
//
//{
//    "id": "33387355662",
//    "owner": "111919763@N07",
//    "secret": "9a67bd13c2",
//    "server": "646",
//    "farm": 1,
//    "title": "La plage d'Haukland/ Adventure land",
//    "ispublic": 1,
//    "isfriend": 0,
//    "isfamily": 0,
//    "url_n": "https://farm1.staticflickr.com/646/33387355662_9a67bd13c2_n.jpg",
//    "height_n": 213,
//    "width_n": "320"
//}

class Photo: NSObject {
    
    var id : String!
    var width : CGFloat = 0.0
    var height : CGFloat = 0.0
    var url : URL!
    var title : String?
    var image : UIImage?
    
    init(dictionary: [String: AnyObject]) {
        
        print(dictionary)
        
        if let val = dictionary["id"] as? String {
            self.id = val
        }
        
        if let val = dictionary["width_n"] as? NSString {
            self.width = CGFloat(val.integerValue)
        }
        else if let val = dictionary["width_n"] as? NSNumber {
            self.width = CGFloat(val)
        }

        if let val = dictionary["height_n"] as? NSString {
            self.height = CGFloat(val.integerValue)
        }
        else if let val = dictionary["height_n"] as? NSNumber {
            self.height = CGFloat(val)
        }
        
        if let val = dictionary["url_n"] as? String {
            self.url = URL(string: val)
        }
        
        if let val = dictionary["title"] as? String {
            self.title = val
        }
    }
}
