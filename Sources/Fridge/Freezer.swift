//
//  Freezer.swift
//  Fridge
//  Copyright (c) 2016-2022 Veljko Tekelerović

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

// MARK: -
final class Freezer {
    /// Freezes an object into Fridge persistant storage. Any new object will overwrite previously stored object
    func freeze<T: Encodable>(object: T, identifier: String) throws { //async ?
        do {
            // 1. initialize fridge compartment for given key
            let comp = FridgeCompartment(key: identifier)
            
            // 2. initialize Streamer with produced compartment
            let writer = BSONConverter(compartment: comp)
            
            // 3. perform stream write of given object
            try writer.write(object: object)
        } catch {
            throw FreezingErrors.dataStoringError
        }
    }
    
    /// Unfreezes an object from Fridge persistant storage.
    func unfreeze<T: Decodable>(identifier: String) throws -> T {
        do {
            // 1. setup compartment
            let comp = FridgeCompartment(key: identifier)
            
            // 2. initialize Streamer with created compartment
            let reader = BSONConverter(compartment: comp)
            
            // 3. perform stream read
            let storedObject: T = try reader.read()
            return storedObject
        } catch {
            print("THROW HAPPENED")
            throw FreezingErrors.dataReadingError
        }
    }
    
    /// Returns `true` if a given object has been frozen previously.
    func isAlreadyFrozen(identifier: String) -> Bool {
        FridgeCompartment(key: identifier).alreadyExist
    }
}
