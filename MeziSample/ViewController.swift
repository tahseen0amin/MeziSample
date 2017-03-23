//
//  ViewController.swift
//  MeziSample
//
//  Created by Taseen Amin on 20/03/17.
//  Copyright © 2017 Tasin Zarkoob. All rights reserved.
//

import UIKit

let WAIT_TIME = 10.0

class ViewController: UIViewController {

    var startX = 0.0 as CGFloat
    var startY = 0.0 as CGFloat

    var handler = PhotoHandler()
    var waitForTimer = true
    var batchPhotoArray = [Photo]()
    var timer : Timer!
    var reUsableImageViews: [UIImageView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getAllPhotos()
        (self.view as! UIScrollView).isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.optimize()
    }

    private func getAllPhotos(){
        self.showLoadingIndicator()
        PhotoService.downloadPhotoData { (photos) in
            self.hideLoadingIndicator()
            self.handler.photos.append(contentsOf: photos)
            self.waitForTimer = false
            self.prepareNextPhotos()
        }
    }
    
    func prepareNextPhotos() {
        let arr = handler.photoForNextPage()
        if arr.count == 0 {
            return
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: WAIT_TIME, target: self,selector: #selector(self.checkIfDownloaded), userInfo:nil, repeats: false)
        self.batchPhotoArray = arr
        
        for ph in arr {
            DownloadImageService.downloadImage(withUrl: ph.url, completionHandler: { (img) in
                ph.image = img
                self.checkIfReadyToLoad()
                print("Hit For Download Image")
            })
        }
        
        // optmize
        self.optimize()
    }
    
    func checkIfDownloaded(timer: Timer){
        self.waitForTimer = false
        print("Hit For Timer ")
        self.checkIfReadyToLoad()
    }
    
    let queue = DispatchQueue(label: "CheckDownloadQueue")
    func checkIfReadyToLoad(){
        queue.sync {
            var ready = true
            for ph in self.batchPhotoArray {
                if ph.image == nil {
                    ready = false
                }
            }
            
            if ready && self.waitForTimer == false {
                print("show")
                self.timer.invalidate()
                DispatchQueue.main.async {
                    self.loadDownloadedImages()
                    self.waitForTimer = true
                    self.prepareNextPhotos()
                }
            }
        }
        
        
    }
    
    func loadDownloadedImages(){
        let array = self.batchPhotoArray
        let size = UIScreen.main.bounds.size
        var topPhotoRect : CGRect!
        for i in 0...(array.count-1) {
            let ph = array[i]
            var imgView : UIImageView!
            if i < (self.reUsableImageViews.count - 3) { // I dont want last 3 images of slideshow to go away
                imgView = self.reUsableImageViews.removeFirst()
                self.reUsableImageViews.append(imgView)
            } else {
                imgView = UIImageView()
                self.reUsableImageViews.append(imgView)
            }
            if startX + ph.width + HORIZONTAL_PADDING + HORIZONTAL_PADDING >= size.width {
                startX = 0
            }
            let frame = CGRect.init(x: startX+HORIZONTAL_PADDING, y: startY+VERTICAL_PADDING, width: ph.width, height: ph.height)
            imgView.frame = frame
            imgView.backgroundColor = UIColor.randomColor()
            imgView.image = ph.image
            self.view.addSubview(imgView)
            // center the image
            if ph.width + HORIZONTAL_PADDING + HORIZONTAL_PADDING < size.width {
                imgView.center.x = self.view.center.x
            }
            startX = startX + HORIZONTAL_PADDING + ph.width + HORIZONTAL_PADDING
            startY = startY + VERTICAL_PADDING + ph.height + VERTICAL_PADDING
            topPhotoRect = frame
        }
        (self.view as! UIScrollView).contentSize = CGSize.init(width: size.width, height: startY)
        (self.view as! UIScrollView).scrollRectToVisible(topPhotoRect!, animated: true)
        //(self.view as! UIScrollView).contentOffset = CGPoint.init(x: 0, y: topPhotoRect.origin.y)

    }
    
    func optimize(){
        if self.handler.doneCount < 6 {
            return
        }
        for i in  0...(self.handler.doneCount - 6){
            let ph = self.handler.photos[i]
            ph.image = nil
        }
    }
}

