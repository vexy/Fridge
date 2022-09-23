/*
 MIT License

 Copyright (c) 2022 Veljko Tekelerovic

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

/// Trivial Storage implementation
internal struct FridgeCompartment {
    // Reference to shared FileManager
    private let _fileManager = FileManager.default
    
    // Internal BLOB file extension
    private let BLOB_EXTENSION: String = ".fridgeStore"

    // key used to identify raw content
    private let key: String
    
    /// Retuns new `FridgeCompartment` with given `key` identifier
    init(key: String) {
        self.key = key
    }
    
    /// Returns `URL` based file path of this compartment
    var objectPath: URL {
        // TODO: Alter between DocumentsDirectory and CacheDirectory later
        guard let documentDirectoryURL = _fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("<Fridge.Storage> Unable to compute DocumentsDirectory path")
        }
        return documentDirectoryURL.appendingPathComponent(storageName)
    }
    
    /// Returns the compartment name formatted by key and static identifier
    private var storageName: String {
        key + BLOB_EXTENSION
    }
    
    /// Returns `true` if raw data already exists at this compartment, `false` otherwise
    var alreadyExist: Bool {
        _fileManager.fileExists(atPath: objectPath.path)
    }
    
    /// Removes compartment from persistent storage
    func remove() {
        try? _fileManager.removeItem(atPath: objectPath.path)
    }
}
