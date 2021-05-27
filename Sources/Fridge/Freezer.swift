//
//  Freezer.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 21.1.20.

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

import Foundation

final class Freezer {
//-------
    internal enum FreezingErrors: Error {
        case dataStoringError
        case dataReadingError
        case unexpected
    }
//-------
    
    private let fileManager = FileManager.default
    
    /// Representation of an `URL` storage concept
    private var Storage : URL {
        //get documents directory
        guard let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("<Fridge> Unable to compute DocumentsDirectory path")
        }
        
        //append storage file name
        let fridgeStoragePath: String = ".fridgeStorage"
        let finalURL = documentDirectoryURL.appendingPathComponent(fridgeStoragePath)
        return finalURL
    }
// MARK: -
    
//    init() {}
    
    /// Freezes an object into Fridge persistant storage. Any new object will overwrite previously stored object
    func freeze<T: Encodable>(object: T) throws {
        do {
            try resetStorage()
            
            let encodedData = encode(object: object)
            saveData(encodedData)
        } catch {
            throw FreezingErrors.dataStoringError
        }
    }
    
    /// Unfreezes an object from Fridge persistant storage.
    func unfreeze<T: Decodable>() throws -> T {
        do {
            //get binary data
            let binaryData = getSavedData()
            print("Binary data is : \(binaryData)")
            
            //encode
            let encoder = JSONDecoder()
            let unfrozenObject = try encoder.decode(T.self, from: binaryData)
            print("** RETURNED: \(unfrozenObject)")
            return unfrozenObject
        } catch {
            print("THROW HAPPENED")
            throw FreezingErrors.dataReadingError
        }
    }
    
    /// Returns `true` if a given object has been frozen previously.
    func isAlreadyFrozen(object: Any) -> Bool {
        #warning("Not implemented")
        return false
    }
}

// MARK: - Utilities
extension Freezer {
    /// Returns JSONEncoded`Data` of a given `Encodable`
    fileprivate func encode<T: Encodable>(object: T) -> Data {
        let coder = JSONEncoder()
        guard let codedData = try? coder.encode(object) else {
            print("Problem encoding [\(object)]")
            fatalError("<Fridge> Unable to encode given data.")
        }
        return codedData
    }
    
    /// Returns saved `Data` from the Storage
    fileprivate func getSavedData() -> Data {
        guard let storageData = try? Data(contentsOf: Storage) else {
            fatalError("<Fridge> Unable to read storage file")
        }
        print("STORAGE DATA: \(storageData)")
        return storageData
    }
    
    /// Saves `Data` into the Storage
    fileprivate func saveData(_ theData: Data) {
        let success = fileManager.createFile(atPath: Storage.path, contents: theData, attributes: nil)
        print("File created - [\(success)], \(theData.count) bytes written")
    }
    
    fileprivate func resetStorage() throws {
        if fileManager.fileExists(atPath: Storage.path) {
            try fileManager.removeItem(at: Storage)
            print("Previous Freezer file noticed and deleted.")
        }
    }
}

extension Freezer: CustomDebugStringConvertible {
    var debugDescription: String {
        let o = "Freezer [\(Storage.path)]"
        let c = getSavedData().count.description
        return o + "\nSize: " + c
    }
}
