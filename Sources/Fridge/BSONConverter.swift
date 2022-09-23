//
//  BSONConverter.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 19.2.22.
//

import Foundation
import BSONCoder

/// Internal helper struct that wraps generic array
fileprivate struct WrappedObject<T: Codable>: Codable, Identifiable {
    var id = BSONObjectID.init()
    var array: [T]
    
    init(arrayObject: [T]) {
        array = arrayObject
    }
}

/// Utility class providing write/read BSON functionality
final class BSONConverter {
    private let _rawFilePath: URL

    init(compartment: FridgeCompartment) {
        _rawFilePath = compartment.objectPath
    }
    
    /// Writes given object to a local system storage
    func write<T: Encodable>(object: T) throws {
        var rawData: Data

        do {
            rawData = try BSONEncoder().encode(object).toData()
        } catch let err {
            print("<BSONConverter> Error occured. Reason:\n\(err)")
            throw err
        }
        
        // flush the data to a file
        try rawData.write(to: _rawFilePath)
    }
    
    /// Writes given array of objects to a local system storage
    func write<T: Codable>(objects: [T]) throws {
        var rawData: Data
        let wrappedObject = WrappedObject<T>.init(arrayObject: objects)
        
        do {
            rawData = try BSONEncoder().encode(wrappedObject).toData()
        } catch let err {
            print("<BSONConverter> Error occured. Reason:\n\(err)")
            throw err
        }
        
        // flush the data to a file
        try rawData.write(to: _rawFilePath)
    }
    
    /// Reads object from compartment data storage and returns Foundation counterpart
    func read<T: Decodable>() throws -> T { //} -> BSONDoc {
        // prepare input stream
        let rawBSONData = try Data(contentsOf: _rawFilePath)
        
        let realObject = try BSONDecoder().decode(T.self, from: rawBSONData)
        return realObject
    }
    
    /// Reads array of objects from compartment data storage and returns Foundation counterpart
    func read<T: Codable>() throws -> [T] {
        // get raw data from the storage
        let rawBSONData = try Data(contentsOf: _rawFilePath)
        
        let wrappedObject = try BSONDecoder().decode(WrappedObject<T>.self, from: rawBSONData)
        return wrappedObject.array
    }
}
