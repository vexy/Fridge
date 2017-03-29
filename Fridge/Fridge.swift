//
//  Downloader.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
/*
 MIT License
 
 Copyright (c) 2016 Veljko Tekelerović
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

*/

//
//  - CLASS MAIN RESPONSIBILITY -
//
//  Provide wrapper around Fridge actions

import Foundation


/** Class used to asynchronously download object from the internet in the background */
class Fridge : NSObject, DownloadObserver {
    
    //serial queue used for storing/retreiving taskIDs
    private let synchronizer = DispatchQueue(label: "com.vexscited.fridge.synchronizer", qos: DispatchQoS.userInitiated)
    
    //dictionary of DownloadTask(s) and appropriate DownloadItem(s)
    private var taskIDs : Dictionary<Int, FridgeItem> = Dictionary<Int,FridgeItem>()
    
    
    //shared singleton instance
    public static let shared = Fridge()
    
    //default initializer
    private override init() {
        super.init()
        
        taskIDs.removeAll()
    }
    
    /**
        Starts downloading an item
     
        - parameters:
            - item: `FridgeItem` to be downloaded
    */
    func download(item : FridgeItem) {
        print("<⚙> Starting download of: \(item.url.absoluteString)")
        
        let fetcher = Downloader(with: self)
        fetcher.fetch(object: item)
        
        /*
        let downloadTask = downloadSession!.downloadTask(with: item.url)
        
        print("<⚙> Adding single task #\(downloadTask.taskIdentifier) (URL : \(item.url.absoluteString))")
        
        //add this download task to our protected collection
        synchronizer.sync {
            taskIDs[downloadTask.taskIdentifier] = item
        }
        
        dispatcher.async {
            downloadTask.resume()
        }
        */
    }
    
    func downloadCompleted(object location: URL) {
        print("<Fridge> File downloaded to: \(location.path)")
    }
    
    func downloadErrored(error: FridgeError) {
        print("<Fridge> Downloade errored: \(error)")
    }
    
    /**
        Starts downloading array of items
 
        - parameters:
            - items: array of `FridgeItem`s to be downloaded
    */
    func download(items : [FridgeItem]) {
        /*
        for item in items {
            let downloadTask = downloadSession!.downloadTask(with: item.url)
            
            //add this downloadable to tracker
            synchronizer.sync {
                taskIDs[downloadTask.taskIdentifier] = item
            }
            
            //start downloading tasks asynchronously
            dispatcher.async {
                print("<⚙> Adding task #\(downloadTask.taskIdentifier) (URL : \(item.url.absoluteString))")
                downloadTask.resume()
            }
        }
        */
        
        let dl = Downloader(with: self)
        
        for item in items {
            print("<⚙> Starting download of: \(item.url.absoluteString)")
            dl.fetch(object: item)
        }
    }
    
    /*
    //protected addition of DownloadTask
    private func add(task: URLSessionDownloadTask) {
        
    }
    
    //protected removal of DownloadTasks
    private func remove(task : URLSessionDownloadTask) {
        
    }
    */
}


