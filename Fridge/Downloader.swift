//
//  Downloader.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 27.2.17.
//
//

import Foundation

protocol DownloadObserver: class {
    func downloadCompleted(object location: URL)
    func downloadErrored(error: FridgeError)
}

class DownloaderFactory {
    static let queueName =          "vexscited.fridge.download-queue"
    static let sessionIdentifier =  "vexscited.fridge.background-url-session"
    
    class func buildFridgeQueue() -> OperationQueue {
        let newQueue = OperationQueue()
        
        newQueue.name = queueName  //"vexscited.fridge.download-queue"
        newQueue.qualityOfService = .background
        newQueue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        
        return newQueue
    }
    
    class func buildFridgeSession(for delegate: URLSessionDownloadDelegate, on queue: OperationQueue) -> URLSession {
        let configuration = URLSessionConfiguration.background(withIdentifier: sessionIdentifier)
        
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: queue)
    }
}

class Downloader: NSObject, URLSessionDownloadDelegate {
    
    private let dispatcher = DispatchQueue(label: "vexscited.fridge.downloader", qos: DispatchQoS.utility, attributes: DispatchQueue.Attributes.concurrent)
    private var queueManager = OperationQueue()
    private var downloadSession : URLSession = URLSession.shared
    
    private weak var delegate: DownloadObserver?
    
    override init() {
        super.init()
        
        queueManager = DownloaderFactory.buildFridgeQueue()
        downloadSession = DownloaderFactory.buildFridgeSession(for: self, on: queueManager)
        
        print("<Fridge.Downloader> Initialization done, DispatchQueue: \(dispatcher.label)")
    }
    
    init(with observer: DownloadObserver) {
        super.init()
        
        self.delegate = observer
        queueManager = DownloaderFactory.buildFridgeQueue()
        downloadSession = DownloaderFactory.buildFridgeSession(for: self, on: queueManager)
        
        print("<Fridge.Downloader> Initialization done, DispatchQueue: \(dispatcher.label)")
    }
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        dispatcher.async {
            print("⏺ <Fridge.Downloader> Data task #\(downloadTask.taskIdentifier) completed")
            self.delegate?.downloadCompleted(object: location)
        }
        
        
        /*
        guard downloadItem != nil else { print("Unable to obtain download item"); return }
        
        let taskID = downloadTask.taskIdentifier
        print("⏺ Task #\(taskID): Download completed, temporary file path : \(location.absoluteString)")
        print("⏺ Task #\(taskID): Kicking off file manager duties ~~SYNC~~")
        
        synchronizer.sync {
            //initialize ItemFileManager with this FridgeItem
            let manager = ItemFileManger(file: downloadItem!, source: location)
            
            do {
                
                let permaLocation = try manager.storePermanently()
                
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
        */
    }
    
    /// Downloads an object from the internet
    func fetch(object: FridgeItem) {
        let task = downloadSession.downloadTask(with: object.url)
        
        print("<Fridge.Downloader> Starting data task: <\(task.taskIdentifier)> on queue: \(downloadSession.delegateQueue.name!)")
        
        dispatcher.async {
            task.resume()
        }
        
        /*
        task.resume()
        */
    }
    
    override var debugDescription: String {
        return "<Fridge.Downloader> Active downloads: \(queueManager.operationCount)"
    }
    
    deinit {
        let output = "<Fridge.Downloader> Operations remaining: \(queueManager.operationCount)..."
        queueManager.cancelAllOperations()
        print("<Fridge.Downloader>\(output) -> all operations canceled")
        print("Downloader deinitialized")
    }
}
