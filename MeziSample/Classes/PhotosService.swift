//
//  FKPhotoRequest.swift
//  MeziSample
//
//  Created by Taseen Amin on 21/03/2017.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit

class PhotosRequest: Request {

    override func completeBody() {
        self.apiEndpoint = "rest/?method=flickr.interestingness.getList&api_key=d98f34e2210534e37332a2bb0ab18887&format=json&extras=url_n"
        super.completeBody()
    }
    
    override func getResponseObject() -> Response {
        
    }
}
