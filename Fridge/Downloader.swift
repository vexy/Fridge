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


struct DownloadableObject {
    var objectURL : URL
    var onComplete : () -> () = {}
    
    init(withURL u : URL) {
        objectURL = u
    }
    
    init(){
        objectURL = URL(string: "https://www.google.com")!
    }
}

/** Class used to asynchronously download object from the internet in the background */
class Downloader : NSObject, URLSessionDownloadDelegate {
    private var objects : [DownloadableObject]

    private let queue = DispatchQueue(label: "com.vexscited.fridge.downloader", qos: DispatchQoS.utility)
    private let opQueue = OperationQueue()
    //
    private var background : URLSessionConfiguration?
    private var downloadSession : URLSession?
    
    private var taskIDs : Dictionary<Int, DownloadableObject> = Dictionary<Int,DownloadableObject>()
    
    init(withObject o : DownloadableObject) {
        objects = [DownloadableObject()]
        objects[0] = o
        
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        super.init()
        
        
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
    }
    
    init(withObjects o : [DownloadableObject]) {
        objects = o
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        super.init()
        
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
    }
    
    private func sessionSetup() {
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: nil)
    }
    
    func download() {
        //cycle through entire collection of DownloadableObjects
        print("<Downloader> Total objects to be downloaded : \(objects.count)")
        for item in objects {
            let downloadTask = downloadSession!.downloadTask(with: item.objectURL)
            
            //add this downloadable to tracker
            taskIDs[downloadTask.taskIdentifier] = item
            
            //start download task asynchronously
            queue.async {
                print("💣 <Downloader> Queuing task # \(downloadTask.taskIdentifier)")
                downloadTask.resume()
            }
        }
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //print the path of the downloaded file
        let downloadableObject = taskIDs[downloadTask.taskIdentifier]
        
        print("⏺ Task #\(downloadTask.taskIdentifier) completed.\nDownloaded file path : \(location.absoluteString) -> onComplete()...")
        
        //dumb compy of this object to /Desktop directory
        let desktopDirectoryPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.desktopDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        let newFileName = desktopDirectoryPath + "/Fridge/tempFile" + downloadTask.taskIdentifier.description + ".png"
        let destinationURL = URL(fileURLWithPath: newFileName)
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
        }catch {
            print("Error copying file to destination ; \(error.localizedDescription)")
        }
        
        downloadableObject?.onComplete()
    }
}


