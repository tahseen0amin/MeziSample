//
//  Extensions.swift
//  MeziSample
//
//  Created by Taseen Amin on 21/03/2017.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func showLoadingIndicator(){
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.tag = 33990
        var centralPoint = self.view.center
        centralPoint.x = centralPoint.x - indicatorView.frame.size.width/2
        centralPoint.y = centralPoint.y - indicatorView.frame.size.height/2
        indicatorView.frame = CGRect(origin: centralPoint, size: indicatorView.frame.size)
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
    }
    
    func hideLoadingIndicator() {
        if let indicatorView = self.view.viewWithTag(33990) as? UIActivityIndicatorView{
            indicatorView.stopAnimating()
            indicatorView.removeFromSuperview()
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
