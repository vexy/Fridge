//
//  Downloader.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 27.2.17.
//
//

import Foundation

class Downloader : URLSessionDownloadDelegate {
    //concurent queue used for starting network tasks
    private let dispatcher = DispatchQueue(label: "com.vexscited.fridge.network_dispatcher", qos: DispatchQoS.utility, attributes: DispatchQueue.Attributes.concurrent)
    private let opQueue = OperationQueue()
    //
    private var background : URLSessionConfiguration?
    private var downloadSession : URLSession?
    
    
    init() {
        opQueue.qualityOfService = .background
        opQueue.maxConcurrentOperationCount = 4
        
        background = URLSessionConfiguration.background(withIdentifier: "com.vexscited.fridge.downloader.background")
        downloadSession = URLSession(configuration: background!, delegate: self, delegateQueue: opQueue)
    }
    
    internal func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        var downloadItem : FridgeItem?
        
        //get FridgeItem from synchronizer
        synchronizer.sync {
            downloadItem = taskIDs[downloadTask.taskIdentifier]
        }
        
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
    }
}
