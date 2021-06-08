/*
 RECREATED BY VEXY @ Januarry 16, 2020 9:50pm
 
                *   FRIDGE  *

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

enum FridgeErrors: Error {
    case grabFailed
}

public struct Fridge {
    /// Tries to freeze an object into persistant storage (if possible).
    public static func freeze🧊<T: Codable>(_ object: T) throws {
        let freezer = Freezer()
        do {
            try freezer.freeze(object: object)
        } catch {
            throw Freezer.FreezingErrors.dataStoringError
        }
    }
    
    /// Tries to grab an object from a given `URL`
    @available(iOS 9999, *)
    public static func grab🔮<D: Decodable> (from url: URL) async throws -> D {
        let grabster = Grabber()
        let grabbedObject: D = try await grabster.grab(from: url)
        return grabbedObject
    }
    
    /// Tries to grab an object using given `URLRequest`
    public static func grab🔮(using urlRequest: URLRequest) throws -> Int {
        return 0
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
