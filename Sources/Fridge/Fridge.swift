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
    /// Tries to grab an object from a given `URL`
    public static func grab🔮<D: Decodable>(from url: URL) async throws -> D {
        let grabster = Grabber()
        let grabbedObject: D = try await grabster.grab(from: url)
        return grabbedObject
    }
    
    /// Tries to grab an object using given `URLRequest`
    public static func grab🔮<D: Decodable>(using urlRequest: URLRequest) async throws -> D {
        let grb = Grabber()
        let theObject: D = try await grb.grab(using: urlRequest)
        return theObject
    }
}

//MARK: - Object persistent storage
extension Fridge {
    /// Tries to freeze an object into persistant storage (if possible).
    public static func freeze🧊<E: Encodable>(_ object: E, id: String) throws {
        let freezer = Freezer()
        do {
            try freezer.freeze(object: object, identifier: id)
        } catch let err {
            print("<Fridge.Freezer> Error occured: \(err.localizedDescription)")
            throw FreezingErrors.dataStoringError
        }
    }
    
    /// Tries to unfreeze an object from persistant storage.
    public static func unfreeze<D: Decodable>(_ key: String) throws -> D {
        let unfreezer = Freezer()
        do {
            let unfrozenObject: D = try unfreezer.unfreeze(identifier: key)
            return unfrozenObject
        } catch {
            throw FreezingErrors.dataStoringError
        }
    }
    
    /// Drops an object from persistant storage.
    public static func dr🕳p(_ key: String) {
//        #warning("Incomplete implementation")
        //try to drop an item from storage
        FridgeCompartment(key: key).remove()
    }
}

//MARK: - Extra goodies
extension Fridge {
    /// This method is methodically designed to raise your moral my dear friend. Use it ONLY in emergency
    public static func greetFellowProgrammers() {
        let theText =
        """
                            ❄️ Freezyall !
          Be greeted by Fridge creator, wherever he is in the 🌍 now !
          Remember 🧠
          Your hard work will pay off, just keep (git) pushing !

          Yours truly,
          Vex - The Fridge grandpa
          🙏
        """
        print(theText)
    }
    
    /// Computes unix timestamp of a Fridge update. Method may throw occasionally.
    public static func willFrigeBeUpdatedSoon() throws -> Bool {
        enum whoKnows: Error { case unknownAnswer }
        throw whoKnows.unknownAnswer
    }
}
