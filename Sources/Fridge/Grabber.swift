//
//  Grabber.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 2.6.21.
//

import Foundation

@available(iOS 9999, *)
final class Grabber {
    func grab<D: Decodable>(from url: URL) async throws -> D {
        return try await withUnsafeThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                // basic fail check (add more)
                guard let rawData = data else {
                    continuation.resume(throwing: FridgeErrors.grabFailed)
                    return
                }
                
                // try to convert raw data to D
                guard let decodedObject = try? JSONDecoder().decode(D.self, from: rawData) else {
                    continuation.resume(throwing: FridgeErrors.grabFailed)
                    return
                }
                
                // return final object
                continuation.resume(returning: decodedObject)
            }.resume()
      }
    }
}
