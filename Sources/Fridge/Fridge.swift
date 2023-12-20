/*
 Copyright (c) 2016 Veljko Tekelerović
 RECREATED BY VEXY @ Januarry 16, 2020 9:50pm
 
 MIT License

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

/*      PUBLIC  *   FRIDGE  *   INTERFACE        */
public struct Fridge {
    // ADD OTHER STUFF HERE
}

//MARK: - Network object fetching (iOS 15+ only)
@available(macOS 12.0, *)
@available(iOS 15.0, *)
extension Fridge {
    /**
     Tries to grab an object from a given `URL` endpoint returning Foundation based type.
     
     Function expect that returning object conforms to `Decodable`.
     If it fails to parse an object it will throw and error.
    
    - Returns: Foundation based `Decodable` object
    - Parameters:
       - url: Fully formated `URL` of a desired endpoint
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.8`
    - SeeAlso: [FridgeErrors](errors.swift)
    */
    public static func grab🔮<D: Decodable>(from url: URL) async throws -> D {
        let grabster = Grabber()
        let grabbedObject: D = try await grabster.grab(from: url)
        return grabbedObject
    }
    
    
    /**
     Tries to grab an object using provided `URLRequest` returning foundation based type.
    
     Function expect that returning object conforms to `Decodable`.
     If it fails to parse an object it will throw and error.
   
    - Returns: Foundation based `Decodable` object
    - Parameters:
       - urlRequest: Fully formated `URLRequest` of a desired endpoint
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.8`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func grab🔮<D: Decodable>(using urlRequest: URLRequest) async throws -> D {
        let grb = Grabber()
        let theObject: D = try await grb.grab(using: urlRequest)
        return theObject
    }
    
    /**
     Tries to push an object to a given `URL` string returning Foundation based response.
    
     Function expect that both provide object conforms to `Encodable` and return type conforms to `Decodable`. Failing to provide conformance will result in throwing an error.
   
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func push📡<E: Encodable, D: Decodable>(_ object: E, to: String) async throws -> D {
        let pusher = Grabber()
        let pushResponseObject: D = try await pusher.push(object: object, urlString: to)
        return pushResponseObject
    }
    
    /**
     Tries to push an object using provided `URLRequest` returning Foundation based response.
    
     Function expect that both provided object conforms to `Encodable` and return type conforms to `Decodable`. Failing to provide conformance will result in throwing an error.
   
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func push📡<E: Encodable, D: Decodable>(_ object: E, using request: URLRequest) async throws -> D {
        let pusher = Grabber()
        let pushResponseObject: D = try await pusher.push(object: object, urlRequest: request)
        return pushResponseObject
    }
}

//MARK: - Object persistent storage
extension Fridge {
    /**
     Tries to freeze given object into persistant storage.
   
     Function expect that both provided object conforms to `Encodable`. Failing to provide conformance will result in throwing an error.
  
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure or `JSONEncodingError` in case of JSON parsing issues
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func freeze🧊<E: Encodable>(_ object: E, id: String) throws {
        // initialize the compartment with given ID
        let freezingCompartment = FridgeCompartment(key: id)
        
        // try to encode the data
        let objectData = try JSONEncoder().encode(object)
        
        // flush the data into the disk
        // rethrow errors if any
        try freezingCompartment.store(data: objectData)
    }
    
    /**
     Tries to freeze an array of given object into persistant storage.
   
     Function expect that passed array conforms to `Encodable`. Failing to provide conformance will result in throwing an error.
  
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure or `JSONEncodingError` in case of JSON parsing issues
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9.3`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func freeze🧊<C: Encodable>(_ objects: [C], id: String) throws {
        // initialize the compartment with given ID
        let freezingCompartment = FridgeCompartment(key: id)
        
        // try to encode the data
        let objectsData = try JSONEncoder().encode(objects)
        
        // flush the data into the disk
        // rethrow errors if any
        try freezingCompartment.store(data: objectsData)
    }
    
//MARK: --
    
    /**
     Tries to unfreeze an object from persistant storage.
   
     Function expect that passed object conforms to `Decodable`. Failing to provide conformance will result in throwing an error.
  
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func unfreeze🪅🎉<D: Decodable>(_ key: String) throws -> D {
        // setup compartment
        let unfreezingCompartment = FridgeCompartment(key: key)
        
        // try to load raw data
        let rawData = try unfreezingCompartment.load()
        
        // try to perform data decoding
        let decodedData = try JSONDecoder().decode(D.self, from: rawData)
        //
        return decodedData
    }
    
    /**
     Tries to unfreeze an array of objects from persistant storage.
   
     Function expect that both passed object conforms to `Codable` and resulting structure conforms to `Codable`. Failing to provide conformance will result in throwing an error.
  
    - Returns: Foundation based `Decodable` object
    - Throws: `FridgeErrors` depending on the condidion of the failure
    - Author: Vexy (https://github.com//vexy)
    - Since: `Fridge 0.9.3`
    - SeeAlso: [FridgeErrors](Errors.swift)
    */
    public static func unfreeze🪅🎉<C: Codable>(_ key: String) throws -> [C] {
        // setup compartment
        let unfreezingCompartment = FridgeCompartment(key: key)
        
        // try to load raw data
        let rawData = try unfreezingCompartment.load()
        
        // try to perform data decoding
        let decodedData = try JSONDecoder().decode([C].self, from: rawData)
        //
        return decodedData
    }
}

//MARK: - Utilities
extension Fridge {
    /// Returns `true` if Fridge contains object with given key
    public static func isFrozen🔬(_ key: String) -> Bool {
        FridgeCompartment(key: key).alreadyExist
    }
    
    /// Drops an object from persistant storage.
    public static func drop🗑(_ key: String) {
        FridgeCompartment(key: key).remove()
    }
}

//MARK: - Extra goodies
extension Fridge {
    /**
     This method is **methodically designed** to raise your moral my dear friend. 🧿
    
     Use it **ONLY** in emergency or if you get struck by *Imposture Syndrom*.
     #imposturesyndrom
   
    - Author: Vexy - https://github.com//vexy
    - Since: `Fridge 0.1`
    - SeeAlso: Other work done by [Vexy](https://github.com//vexy)
    */
    public static func greetFellowProgrammers🤠() {
        let theText =
        """
                            ❄️ !! Freezyall !! ❄️
          Be greeted by **Fridge creator**, wherever he is in the 🌍 now !
          **Remember 🧠**
          Your hard work will pay off, just keep (*git*) pushing !

          Yours truly,
          Vex - The Fridge grandpa
          🙏
        """
        print(theText)
    }
    
    /**
     Computes unix timestamp of a `Fridge` next update - in a peculiar way.
    
     Method may throw occasionally...
   
    - Author: Vexy - https://github.com//vexy
    - Since: `Fridge 0.1`
    - SeeAlso: Other work done by [Vexy](https://github.com//vexy)
    */
    public static func willFrigeBeUpdatedSoon😧() throws -> Bool {
        enum whoKnows: Error { case unknownAnswer }
        throw whoKnows.unknownAnswer
    }
}
