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


/** Class used to asynchronously download object from the internet in the background */
class Downloader : NSObject, URLSessionDownloadDelegate {
    
    //serial queue used for storing/retreiving taskIDs
    private let synchronizer = DispatchQueue(label: "com.vexscited.fridge.synchronizer", qos: DispatchQoS.userInitiated)
    
    //concurent queue used for starting network tasks
    private let dispatcher = DispatchQueue(label: "com.vexscited.fridge.network_dispatcher", qos: DispatchQoS.utility, attributes: DispatchQueue.Attributes.concurrent)
    private let opQueue = OperationQueue()
    //
    private var background : URLSessionConfiguration?
    private var downloadSession : URLSession?
    
    //dictionary of DownloadTask(s) and appropriate DownloadItem(s)
    private var taskIDs : Dictionary<Int, DownloadItem> = Dictionary<Int,DownloadItem>()
    
    private var cachePath : String = ""
    
    //shared singleton instance
    public static let shared = Downloader()
    
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
    func download(item : DownloadItem) {
        let downloadTask = downloadSession!.downloadTask(with: item.itemURL)
        
        print("⚙<Downloader> Adding single task #\(downloadTask.taskIdentifier)")
        
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
    func download(items : [DownloadItem]) {
        for item in items {
            let downloadTask = downloadSession!.downloadTask(with: item.itemURL)
            
            //add this downloadable to tracker
            synchronizer.sync {
                taskIDs[downloadTask.taskIdentifier] = item
            }
            
            //start downloading tasks asynchronously
            dispatcher.async {
                print("⚙<Downloader> Adding task #\(downloadTask.taskIdentifier)")
                downloadTask.resume()
            }
        }
    }
    
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var downloadItem : DownloadItem?
        
        synchronizer.sync {
            downloadItem = taskIDs[downloadTask.taskIdentifier]
        }
//        let downloadedItem = taskIDs[downloadTask.taskIdentifier]
        
        guard downloadItem != nil else { print("Unable to obtain download item"); return }
        
        print("⏺ Task #\(downloadTask.taskIdentifier) completed.\nTemporary file path : \(location.absoluteString)")
        
        do {
            //TODO : think of kicking off another thread here !!
            let result = try permaCopy(item: downloadItem!, at: location)
            print("Temp file copied to : \(result.absoluteString)")
            
            DispatchQueue.main.sync {
                downloadItem?.onComplete(result)
            }
        } catch {
            print("Unable to copy item to it's destination !\nError : \(error.localizedDescription)")
            DispatchQueue.main.sync {
                downloadItem?.onFailure(FridgeError.generalError)
            }
        }
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
    private func permaCopy(item : DownloadItem, at location : URL) throws -> URL {
        //if item has desired location use that as final destination, otherwise copy to (default) Caches folder
        let finalDestination : URL
        let fileName : String = UUID().uuidString + ".tmp"
        var finalFilePath : URL
        
        if let _ = item.desiredLocation {
            finalDestination = item.desiredLocation!
            
            finalFilePath = URL(fileURLWithPath: finalDestination.absoluteString + "/" + fileName)
        } else {
            finalFilePath = URL(fileURLWithPath: cachePath + fileName)
        }
        
        do {
            try FileManager.default.copyItem(at: location, to: finalFilePath)
        } catch {
            print("ERROR : Unable to copy file to final destination !")
            throw FridgeError.generalError
        }
        
        return finalFilePath
    }
}


