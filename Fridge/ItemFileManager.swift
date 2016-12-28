//
//  ItemFileManager.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 27.12.16.
//
//

import Foundation

/// Utility class used to handle file operations
class ItemFileManger {
    private var fridgeFile : URL
    
    //FileManager singleton reference
    fileprivate let fileManager = FileManager.default
    
    //Cache destination folder path
    private var cachePath : String = ""
    
    init(file : URL) {
        fridgeFile = file
        
        //use default system cache directory for this :
        cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/Fridge/"
    }
    
    /// Returns system provided Cache folder
    public var systemCacheFolder : String {
        get {
            return cachePath
        }
    }
    
    /**
        Utility function used to copy downloaded object to specified location.
        
        - parameters:
          - destination: `URL` object where to place this item
     
        - note:
        You can use system provided Cache folder using `ItemFileManager.cachePath`
     
        - throws:
        `FridgeError.fileManagementError` if any file related action won't complete
    */
    func permaCopy(to destination : URL) throws -> URL {
        var fileName : String = ""
        var finalFilePath : URL
        
        fileName = constructFileName()
//        finalFilePath = URL(string: destination.absoluteString + fileName)!
        finalFilePath = URL(fileURLWithPath: destination.absoluteString + fileName)
        
        print("<📁> Checking file existance at : \(finalFilePath.path)")
        do {
            if exists(path: finalFilePath.path) {
                //delete this file :
                try delete(path: finalFilePath.path)
            } else {
                print("<📂> Filename doesn't exist at path ✅")
            }

            //finally try to copy this item to desired destination
            print("<📂> Copying \(fridgeFile.description) to \(finalFilePath.description)")
            try fileManager.copyItem(at: fridgeFile, to: finalFilePath)
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
        
        if fridgeFile.lastPathComponent == "/"  {
            //this could be like : http://www.google.com
            validFileName = UUID().uuidString + ".tmp"
        } else {
            //check if we're dealing with 'naked' file names
            //  eg. /some/folder/withNakedFile
            //  eg. http://foo.bar/request

            if fridgeFile.lastPathComponent.contains(".") {
                validFileName = UUID().uuidString + ".tmp"
            } else {
                validFileName = fridgeFile.lastPathComponent + ".tmp"
            }
        }
        
        return validFileName
    }
    
    private func constructFolderPath() -> String {
        return ""
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
