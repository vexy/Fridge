//
//  Downloader.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//
//  - CLASS MAIN RESPONSIBILITY -
//
//  Download an item from the internet, and provide the URL of downloaded object

import Foundation

//define custom DispatchQueue

//define work item

//accept URL to download

//execute download

//send back downloaded URL object

struct DownloadableObject {
    var objectURL : URL
    var onComplete : () -> () = {}
    
    init(withURL u : URL) {
        objectURL = u
//        onComplete
    }
}

class Downloader {
    private var object : DownloadableObject

//    private let queue = DispatchQueue(label: "com.vexscited.fridge.downloader")
//    private let customSession = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
    
//    let o = URLSessionConfiguration.
    
    init(withObject o : DownloadableObject) {
        object = o
    }
    
    func download() {
//        let sema = DispatchSemaphore(value: 1)
        
        //create download task based on our URL
        print("<DLO> Starting download of : \(object.objectURL.absoluteString) .....")
        
//        let s = URLSession(configuration: customSession)
//        let s = URLSession()
        let dlt = URLSession.shared.downloadTask(with: object.objectURL, completionHandler :
        {
            (fileURL : URL?, serverResponse : URLResponse?, errorCollection : Error?) -> Void in
            
            print("<DLO> Download complete, errors : \(errorCollection?.localizedDescription)")
            
            //examine errors if any (TODO: later !!)
            guard errorCollection == nil else {
                print("<DLO> Error occured, exiting...")
                return
            }
            
            //checkout path to our downloaded resource
            if let f = fileURL {
                print("<DLO> Object located at : \(f.absoluteURL)")
            } else {
                print("<DLO> Object is : \(fileURL?.absoluteURL)")
            }
            
            OperationQueue.main.addOperation {
                print("<DLO> dispatching closure to main queue !")
                self.object.onComplete()
            }
            
            
            //signal semaphore
            print("Signaling semaphore...")
//            sema.signal()
        })
        dlt.resume()    //start actuall download
//        sema.wait(timeout: .distantFuture)
        
        /*
        URLSession().dataTask(with: object.objectURL, completionHandler: {
            (d : Data?, respo : URLResponse?, somerrors : Error?) -> Void in
            
            
        })
        */
    }
}


