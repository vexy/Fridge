//
//  Errors.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 19.2.22.
//

import Foundation

enum FridgeErrors: Error {
    //add case grabFailed(reason: Error) or similar
    case grabFailed
    case pushFailed
    case decodingFailed
}

enum FreezingErrors: Error {
    case dataStoringError
    case dataReadingError
    case unexpected
}

enum FridgeStreamError: Error {
    case streamReadError
    case streamWriteError
}
