//
//  BSONConverter.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 19.2.22.
//

import Foundation
//import SwiftBSON
import BSONCoder

/// Utility class providing write/read BSON functionality
final class BSONConverter {
    let _comp: FridgeCompartment

    init(compartment: FridgeCompartment) {
        _comp = compartment
    }
    
    /// Writes given object to a compartment storage
    func write<T: Encodable>(object: T) throws {
        // declare BSONEncoder
        let rawBSONData = try BSONEncoder().encode(object).toData() //will throw further
        
        // now flush the data to a file
        try rawBSONData.write(to: _comp.filePath)
    }
    
    /// Reads a given object from compartment storage
    func read<T: Decodable>() throws -> T { //} -> BSONDoc {
        // prepare input stream
        let rawBSONData = try Data(contentsOf: _comp.filePath)
        
        let realObject = try BSONDecoder().decode(T.self, from: rawBSONData)
        return realObject
    }
}
