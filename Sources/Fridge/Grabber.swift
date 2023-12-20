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

@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(watchOS 8.0, *)
@available(tvOS 15.0, *)
final internal class Grabber {
    func grab<D: Decodable>(from url: URL) async throws -> D {
        guard let rawData = try? await URLSession.shared.data(from: url).0 else {
            throw FridgeErrors.networkingIssues(reason: "Networking failed")
        }
        guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
            throw FridgeErrors.parsingIssues(reason: "Unable to parse data.")
        }
        // return decoded object
        return decodedObject
    }
    
    func grab<D: Decodable>(using urlRequest: URLRequest) async throws -> D {
        guard let rawData = try? await URLSession.shared.data(for: urlRequest).0 else {
            throw FridgeErrors.networkingIssues(reason: "Networking failed")
        }
        guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
            throw FridgeErrors.parsingIssues(reason: "Unable to parse data.")
        }
        // return decoded object
        return decodedObject
    }

//MARK: -
    func push<E: Encodable, D: Decodable>(object: E, urlString: String) async throws -> D {
        do {
            var request = try constructURLRequest(from: urlString)
            request.httpBody = try serializeObject(object)
            
            //execute request and wait for response
            let responseRawData = try await URLSession.shared.data(for: request).0  //first tuple item contains Data
            
            // try to decode returned data into given return type
            return try deserializeData(responseRawData)
        } catch let e {
            throw e //just rethrow the same error further
        }
    }
    
    func push<E: Encodable, D: Decodable>(object: E, urlRequest: URLRequest) async throws -> D {
        do {
            var request = urlRequest
            request.httpBody = try serializeObject(object)
            
            //execute request and wait for response
            let responseRawData = try await URLSession.shared.data(for: request).0  //first tuple item contains Data
            
            // try to decode returned data into given return type
            return try deserializeData(responseRawData)
        } catch let e {
            throw e //just rethrow the same error further
        }
    }
}

//MARK: - Private helpers
//@available(macOS 12.0, *)
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(watchOS 8.0, *)
@available(tvOS 15.0, *)
extension Grabber {
    /// Constructs a JSON based `URLRequest` from given url `String`
    private func constructURLRequest(from string: String) throws -> URLRequest {
        guard let urlObject = URL(string: string) else { throw FridgeErrors.parsingIssues(reason: "Decoding failed.") }
        var request = URLRequest(url: urlObject)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Fridge.Grabber", forHTTPHeaderField: "User-Agent")
        return request
    }
    
    /// Serialize given object and attach it to request body
    private func serializeObject<E: Encodable>(_ objectToSerialize: E) throws -> Data {
        guard let serializedObject = try? JSONEncoder().encode(objectToSerialize.self) else {
            throw FridgeErrors.parsingIssues(reason: "Decoding failed.")
        }
        return serializedObject
    }
    
    /// Tries to decode given data into given `Decodable` object
    private func deserializeData<D: Decodable>(_ rawData: Data) throws -> D {
        guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
            throw FridgeErrors.parsingIssues(reason: "Decoding failed")
        }
        return decodedObject
    }
}
