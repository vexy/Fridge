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
class Fridge : NSObject, URLSessionDownloadDelegate {
    
    //serial queue used for storing/retreiving taskIDs
    private let synchronizer = DispatchQueue(label: "com.vexscited.fridge.synchronizer", qos: DispatchQoS.userInitiated)
    
    //concurent queue used for starting network tasks
    private let dispatcher = DispatchQueue(label: "com.vexscited.fridge.network_dispatcher", qos: DispatchQoS.utility, attributes: DispatchQueue.Attributes.concurrent)
    private let opQueue = OperationQueue()
    //
    private var background : URLSessionConfiguration?
    private var downloadSession : URLSession?
    
    //dictionary of DownloadTask(s) and appropriate DownloadItem(s)
    private var taskIDs : Dictionary<Int, FridgeItem> = Dictionary<Int,FridgeItem>()
    
    
    //shared singleton instance
    public static let shared = Fridge()
    
    //default initializer
    private override init() {
        super.init()
        
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
        
        taskIDs.removeAll()
    }
    
    /**
        Starts downloading an item
     
        - parameters:
            - item: `FridgeItem` to be downloaded
    */
    func download(item : FridgeItem) {
        let downloadTask = downloadSession!.downloadTask(with: item.url)
        
        print("<⚙> Adding single task #\(downloadTask.taskIdentifier) (URL : \(item.url.absoluteString))")
        
        //add this download task to our protected collection
        synchronizer.sync {
            taskIDs[downloadTask.taskIdentifier] = item
        }
        
        dispatcher.async {
            downloadTask.resume()
        }
    }
    
    /**
        Starts downloading array of items
 
        - parameters:
            - items: array of `FridgeItem`s to be downloaded
    */
    func download(items : [FridgeItem]) {
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
    }
    
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var downloadItem : FridgeItem?
        
        //get FridgeItem from synchronizer
        ///*
        synchronizer.sync {
            downloadItem = taskIDs[downloadTask.taskIdentifier]
        }
        
        guard downloadItem != nil else { print("Unable to obtain download item"); return }
        
        let taskID = downloadTask.taskIdentifier
        print("⏺ Task #\(taskID): Download completed, temporary file path : \(location.absoluteString)")
        print("⏺ Task #\(taskID): Kicking off file manager duties (SYNC) ~~")
        //*/
        
        synchronizer.sync {
            //initialize itemFileManager with this FridgeItem
            let manager = ItemFileManger(file: downloadItem!, source: location)
            
            do {
                
                let permaLocation = try manager.itemPermaCopy()
                
                //perform FridgeItem closure if exists
                DispatchQueue.main.async {
                    downloadItem?.onComplete(permaLocation)
                }
            } catch FridgeError.fileManagementError {
                print("⏺ Task #\(taskID): ERRORED (FILE TROUBLE) -> proceeding with onFailure closure")
                DispatchQueue.main.async {
                    downloadItem?.onFailure( .fileManagementError )
                }
            } catch FridgeError.generalError {
                print("⏺ Task #\(taskID): ERRORED (GENERAL) -> proceeding with onFailure closure")
                DispatchQueue.main.async {
                    downloadItem?.onFailure( .generalError )
                }
            } catch {
                print("⏺ Task #\(taskID) : ERRORED(UNKNOWN), proceeding with onFailure closure")
//                assertionFailure("General error occured !")
                DispatchQueue.main.async {
                    downloadItem?.onFailure( .generalError )
                }
            }
            
            print("⏺ Task #\(taskID):FINISHED\n----------")
        }
    }
    
    //protected addition of DownloadTask
    private func add(task: URLSessionDownloadTask) {
        
    }
    
    //protected removal of DownloadTasks
    private func remove(task : URLSessionDownloadTask) {
        
    }
}


