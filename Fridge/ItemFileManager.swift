//
//  ItemFileManager.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 27.12.16.
//
//

import Foundation

/// Utility class used to handle file operations of given `FridgeItem`
class ItemFileManger {
    private var fridgeFile : FridgeItem
    private var sourceFile : URL
    
    //FileManager singleton reference
    fileprivate let fileManager = FileManager.default
    
    //Cache destination folder path
    private var cachePath : String = ""
    
    /* 
        Creates new instance of `ItemFileManager`
     
        - parameters:
          - file: `FirdgeItem` that needs file operation
          - source: `URL` file containing data that needs manipulation
     
    */
    init(file : FridgeItem, source: URL) {
        fridgeFile = file
        sourceFile = source
        
        //use default system cache directory for this :
        cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/Fridge/"
        handleCacheExistance()
    }
    
    private func handleCacheExistance() {
        //make sure our own cache folder exists
        if !exists(path: cachePath) {
            //create this folder
            do {
                try fileManager.createDirectory(at: URL(fileURLWithPath: cachePath), withIntermediateDirectories: false, attributes: nil)
                print("<📁> Fridge cache folder created !!")
            } catch {
                print("<📁> ERROR : UNABLE TO CREATE CACHE DIRECTORY !! !!")
            }
        } else {
            print("<📁> Fridge cache folder already exists !!")
        }
    }
    
    /// Returns custom Cache folder
    public var fridgeCacheFolder : String {
        get {
            return cachePath
        }
    }
    
    /**
        Utility function that tries to copy downloaded `FridgeItem` to *appropriate* destination
     
     
        - note:
        This class will try to copy given `FridgeItem` to `FridgeItem.downloadDestination` (if exists) otherwise it will try to copy the given item to custom **Fridge cache folder** .
        Cache folder path is computed in `fridgeCacheFolder` property
     
        - throws:
        `FridgeError.fileManagementError` if any file/folder related actions are unable to complete
    */
    func storePermanently() throws -> URL {
        var fileName : String = ""
        var finalFilePath : URL
        
        //setup needed parts
        fileName = constructFileName()
        finalFilePath = handleDownloadPath(withFileName: fileName)
        
        print("<📁> Checking final file existance at : \(finalFilePath.path)")
        do {
            if exists(path: finalFilePath.path) {
                //delete this file :
                try delete(path: finalFilePath.path)
            } else {
                print("<📂> ✅ Final file doesn't exist at path")
            }

            //finally try to copy this item to desired destination
            print("<📂> Copying :\n\tFROM: \(sourceFile.description)\n\tTO : \(finalFilePath.description)...")
//            try fileManager.copyItem(at: sourceFile, to: finalFilePath)
            try fileManager.moveItem(at: sourceFile, to: finalFilePath)
        } catch let err as NSError {
            print("<📂> ERROR : Unable to MOVE file to final destination ! Reason : \(err.localizedDescription)")
            throw FridgeError.fileManagementError
        }
        
        return finalFilePath
    }
    
    //MARK:- Utility file manipulation functions
    
    /// Constructs usable file name out of our `fridgeFile`
    func constructFileName() -> String {
        var validFileName : String = ""
        
        if fridgeFile.url.lastPathComponent.contains(".") {
            validFileName = fridgeFile.url.lastPathComponent
        } else {
            validFileName = UUID().uuidString + ".tmp"
        }
        
        return validFileName
    }
    
    private func handleDownloadPath(withFileName : String) -> URL {
        var downloadPath : URL
        
        if let customPath = fridgeFile.downloadDestination {
            //we have some custom destination, first make sure it exists
            if exists(path: fridgeFile.downloadDestination!.path) {
                downloadPath = customPath.appendingPathComponent(withFileName)
                print("<📁> ✅ Custom download destination exists")
            } else {
                do {
                    try fileManager.createDirectory(at: customPath, withIntermediateDirectories: true, attributes: nil)
                    
                    downloadPath = customPath.appendingPathComponent(withFileName)
                    print("<📁> ✅ Custom download destination created")
                } catch {
                    print("<📁> Custom download destination cannot be created, defaulting to fridgeCacheFolder !")
                    downloadPath = URL(fileURLWithPath: cachePath).appendingPathComponent(withFileName)
                }
                
                /*
                print("<📁> Custom download destination doesn't exists, defaulting to fridgeCacheFolder !")
                downloadPath = URL(fileURLWithPath: cachePath).appendingPathComponent(withFileName)
                */
            }
        } else {
            //there is no custom destination, use Fridge cache instead
            downloadPath = URL(fileURLWithPath: cachePath).appendingPathComponent(withFileName)
        }
        
        return downloadPath
    }
    
    private func exists(path : String) -> Bool {
        return fileManager.fileExists(atPath: path)
    }
    
    private func delete(path : String) throws {
        /*
            Checking file state before attempting file operation is not advisable by Apple Docs
         
        guard fileManager.isDeletableFile(atPath: path) else {
            throw FridgeError.fileManagementError
        }
        */
        
        do {
            try fileManager.removeItem(atPath: path)
            
            print("<📁> File previously existed and is now deleted ! 🗑 ")
        } catch {
            print("<📁> ERROR : Unable to remove item at \(path) 🗑 ")
            throw FridgeError.fileManagementError
        }
    }
}
