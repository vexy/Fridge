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
    private var objects : [DownloadItem] = [DownloadItem()]

    private let queue = DispatchQueue(label: "com.vexscited.fridge.dispatcher", qos: DispatchQoS.utility)
    private let opQueue = OperationQueue()
    //
    private var background : URLSessionConfiguration?
    private var downloadSession : URLSession?
    
    private var taskIDs : Dictionary<Int, DownloadItem> = Dictionary<Int,DownloadItem>()
    
    //shared singleton instance
    public static let shared = Downloader()
    
    //default initializer
    private override init() {
        super.init()
        
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
        
//        downloadSession?.finishTasksAndInvalidate()
        
        taskIDs.removeAll()
    }
    
    /** Starts downloading an item */
    func download(item : DownloadItem) {
        let downloadTask = downloadSession!.downloadTask(with: item.itemURL)
        
        print("⚙<Downloader> Adding single task #\(downloadTask.taskIdentifier)")
        
        taskIDs[downloadTask.taskIdentifier] = item
        downloadTask.resume()
    }
    
    /** Starts downloading array of items */
    func download(items : [DownloadItem]) {
        for item in items {
            let downloadTask = downloadSession!.downloadTask(with: item.itemURL)
            
            //add this downloadable to tracker
            taskIDs[downloadTask.taskIdentifier] = item
            
            //start downloading tasks asynchronously
            queue.async {
                print("⚙<Downloader> Adding task #\(downloadTask.taskIdentifier)")
                downloadTask.resume()
            }
        }
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let downloadedItem = taskIDs[downloadTask.taskIdentifier]
        
        guard downloadedItem != nil else { print("Unable to obtain download task"); return }
        
        print("⏺ Task #\(downloadTask.taskIdentifier) completed.\nTemporary file path : \(location.absoluteString)")
        
        do {
            let result = try permaCopy(item: downloadedItem!, at: location)
            print("Temp file copied to : \(result.absoluteString)")
            
            DispatchQueue.main.sync {
                downloadedItem?.onComplete(result)
            }
        } catch {
            print("Unable to copy item to it's destination !\nError : \(error.localizedDescription)")
            DispatchQueue.main.sync {
                downloadedItem?.onFailure(FridgeError.generalError)
            }
        }
    }
    
    
    
    /** Utility function used to copy downloaded object to disk */
    private func permaCopy(item : DownloadItem, at location : URL) throws -> URL {
        //if item has desired location use that as final destination, otherwise copy to Caches folder
        let finalDestination : URL
        let fileName : String = UUID().uuidString + ".tmp"
        var finalFilePath : URL
        
        if let _ = item.desiredLocation {
            finalDestination = item.desiredLocation!
            
            finalFilePath = URL(fileURLWithPath: finalDestination.absoluteString + "/" + fileName)
        } else {
            let cacheDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/Fridge/"
         
            finalFilePath = URL(fileURLWithPath: cacheDirectory + fileName)
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


