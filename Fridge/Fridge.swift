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
//  Download an item from the network, and provide the URL of downloaded object

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
    
    private var cachePath : String = ""
    
    //shared singleton instance
    public static let shared = Fridge()
    
    //default initializer
    private override init() {
        super.init()
        
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
        
        //use default system cache directory for this :
        cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/Fridge"
        
        taskIDs.removeAll()
    }
    
    /**
        Starts downloading an item
     
        - parameters:
            - item: DownloadItem to be downloaded
    */
    func download(item : FridgeItem) {
        let downloadTask = downloadSession!.downloadTask(with: item.url)
        
        print("⚙<Downloader> Adding single task #\(downloadTask.taskIdentifier) (destination : \(item.url.absoluteString))")
        
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
            - items: array of DownloadItems
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
                print("⚙<Downloader> Adding task #\(downloadTask.taskIdentifier) (destination : \(item.url.absoluteString))")
                downloadTask.resume()
            }
        }
    }
    
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var downloadItem : FridgeItem?
        
        synchronizer.sync {
            downloadItem = taskIDs[downloadTask.taskIdentifier]
        }
//        let downloadedItem = taskIDs[downloadTask.taskIdentifier]
        
        guard downloadItem != nil else { print("Unable to obtain download item"); return }
        
        let taskID = downloadTask.taskIdentifier
        print("⏺ Task #\(taskID) completed :\nTemporary file path : \(location.absoluteString)")
        
        synchronizer.sync {
            print("⏺(#\(taskID)) <-> 📂 Task #\(downloadTask.taskIdentifier), kicking off file manager duties (SYNC)")
            do {
                //TODO : think of kicking off another thread here !!
                let result = try self.permaCopy(item: downloadItem!, at: location)
                print("⏺(#\(taskID)) Temporary file copied to perma location : \(result.absoluteString)")
                
                DispatchQueue.main.sync {
                    downloadItem?.onComplete(result)
                }
            } catch {
                print("⏺(#\(taskID)) Unable to copy item to it's destination !\nError : \(error.localizedDescription)")
                DispatchQueue.main.sync {
                    downloadItem?.onFailure(FridgeError.generalError)
                }
            }
        }
        
        print("⏺ Task #\(taskID) is DONE\n----------")
    }
    
    //protected addition of DownloadTask
    private func add(task: URLSessionDownloadTask) {
        
    }
    
    //protected removal of DownloadTasks
    private func remove(task : URLSessionDownloadTask) {
        
    }
    
    /** Specifies cache destination for downloaded object(s).
     
        If not path is specified, system default cache will be used
    */
    public var cacheDestination : String {
        get {
            return cachePath
        }
        
        set (v) {
            cachePath = v
            print("<Downloader> This is a new value: \(v)")
        }
    }
    
    /** Utility function used to copy downloaded object to specified location */
    private func permaCopy(item : FridgeItem, at location : URL) throws -> URL {
        //if item has desired location use that as final destination, otherwise copy to (default) Caches folder
        let finalDestination : URL
        var fileName : String = ""
        var finalFilePath : URL
        
        if item.url.lastPathComponent == "/"  {
            fileName = UUID().uuidString + ".tmp"
        } else {
            fileName = item.url.lastPathComponent
        }
        
        if let _ = item.desiredLocation {
            finalDestination = item.desiredLocation!
            
            finalFilePath = URL(fileURLWithPath: finalDestination.absoluteString + "/" + fileName)
        } else {
            finalFilePath = URL(fileURLWithPath: cachePath + fileName)
        }
        
        print("📂 Checking file existance at : \(finalFilePath.path)")
        if FileManager.default.fileExists(atPath: finalFilePath.path) {
            do {
                try FileManager.default.removeItem(atPath: finalFilePath.path)
                
                print("📂🗑 Object previously existed and is now deleted !")
            } catch {
                print("📂🗑 ERROR : Unable to remove item at \(finalFilePath.path)")
                throw FridgeError.generalError
            }
        } else {
            print("📂✅ Filename doesn't exist at path")
        }
        
        do {
            try FileManager.default.copyItem(at: location, to: finalFilePath)
        } catch {
            print("📂 ERROR : Unable to copy file to final destination ! Reason : \(error.localizedDescription)")
            throw FridgeError.generalError
        }
        
        return finalFilePath
    }
}


