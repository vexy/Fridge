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
                print("<📁> Fridge cache folder exists !!")
            } catch {
                print("<📁> UNABLE TO CREATE CACHE DIRECTORY !! !!")
            }
        } else {
            print("<📁> Fridge cache folder exists !!")
        }
    }
    
    /// Returns system provided Cache folder
    public var systemCacheFolder : String {
        get {
            return cachePath
        }
    }
    
    /**
        Utility function that tries to copy downloaded `FridgeItem` to *appropriate* destination
        
        - parameters:
          - destination: `URL` object where to place this item
     
        - note:
        This class will try to copy given `FridgeItem` to `FridgeItem.downloadDestination` (if exists) otherwise it will try to copy the given item to system provided **Cache folder** .
        Cache folder path is computed in `systemCacheFolder` property
     
        - throws:
        `FridgeError.fileManagementError` if any file related action won't complete
    */
    func itemPermaCopy() throws -> URL {
        var fileName : String = ""
        var finalFilePath : URL
        
        fileName = constructFileName()
        if let _ = fridgeFile.downloadDestination {
            finalFilePath = fridgeFile.downloadDestination!.appendingPathComponent(fileName)
        } else {
            finalFilePath = URL(fileURLWithPath: systemCacheFolder).appendingPathComponent(fileName)
        }
        
        print("<📁> Checking file existance at : \(finalFilePath.path)")
        do {
            if exists(path: finalFilePath.path) {
                //delete this file :
                try delete(path: finalFilePath.path)
            } else {
                print("<📂> Filename doesn't exist at path ✅")
            }

            //finally try to copy this item to desired destination
            print("<📂> Copying :\n\tFROM: \(sourceFile.description)\n\tTO : \(finalFilePath.description)...")
            try fileManager.copyItem(at: sourceFile, to: finalFilePath)
//            try fileManager.moveItem(at: sourceFile, to: finalFilePath)
        } catch {
            print("<📂> ERROR : Unable to copy file to final destination ! Reason : \(error.localizedDescription)")
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
