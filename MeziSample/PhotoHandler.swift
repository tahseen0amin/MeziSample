//
//  PhotoHandler.swift
//  MeziSample
//
//  Created by Taseen Amin on 3/22/17.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit

let HORIZONTAL_PADDING  = 0.0 as CGFloat
let VERTICAL_PADDING = 2.0 as CGFloat

struct PhotoHandler {
    var photos: [Photo] = [Photo]()
    var doneCount = 0
    mutating func photoForNextPage() -> [Photo] {
        if doneCount >= photos.count {
            return [Photo]()
        }
        let size = UIScreen.main.bounds.size
        var width = 0.0 as CGFloat
        var height = 0.0 as CGFloat
        var available = true
        var filters = [Photo]()
        while available {
            let photo = photos[doneCount]
            let reqHeight = photo.height + VERTICAL_PADDING + VERTICAL_PADDING
            let reqWidht = photo.width + HORIZONTAL_PADDING + HORIZONTAL_PADDING
            if reqHeight > size.height || reqWidht > size.width {
                doneCount += 1
                if doneCount >= photos.count {
                    available = false
                }
                continue
            }
            else if reqWidht + width > size.width {
                height = height + reqHeight
                width = 0
            }
            if width + reqWidht <= size.width && height + reqHeight <= size.height {
                filters.append(photos[doneCount])
                width = width+reqWidht
            }
            if height + reqHeight > size.height {
                available = false
            } else {
                doneCount += 1
            }
            if doneCount >= photos.count {
                available = false
            }
        }
        print("Done count : \(doneCount)")
        return filters
    }
}

