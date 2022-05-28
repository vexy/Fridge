//
//  Grabber.swift
//  Fridge
//  Copyright (c) 2016-2022 Veljko Tekelerović

/*
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

@available(macOS 12.0, *)
@available(iOS 15.0, *)
final internal class Grabber {
    func grab<D: Decodable>(from url: URL) async throws -> D {
        guard let rawData = try? await URLSession.shared.data(from: url).0 else {
            throw FridgeErrors.grabFailed
        }
        guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
            throw FridgeErrors.decodingFailed
        }
        
        // return decoded object
        return decodedObject
    }
    
    func grab<D: Decodable>(using urlRequest: URLRequest) async throws -> D {
        guard let rawData = try? await URLSession.shared.data(for: urlRequest).0 else {
            throw FridgeErrors.grabFailed
        }
        guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
            throw FridgeErrors.grabFailed
        }
        
        // return decoded object
        return decodedObject
    }
    
    
    func push<E: Encodable, D: Decodable>(object: E, urlString: String) async throws -> D {
        //construct a JSON based URLRequest
        guard let urlObject = URL(string: urlString) else { throw FridgeErrors.decodingFailed }
        var request = URLRequest(url: urlObject)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Fridge.grab", forHTTPHeaderField: "User-Agent")
        
        // serialize given object and attach it to request body
        guard let serializedObject = try? JSONEncoder().encode(object.self) else {
            throw FridgeErrors.decodingFailed
        }
        request.httpBody = serializedObject
        
        //execute request and wait for response
        guard let responseRawData = try? await URLSession.shared.data(for: request).0 else {
            throw FridgeErrors.pushFailed
        }
        
        // try to decode the data into given respose object
        guard let decodedResponse = try? JSONDecoder().decode(D.self, from: responseRawData) else {
            throw FridgeErrors.decodingFailed
        }
        
        return decodedResponse
    }
}
