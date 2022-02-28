//
//  Errors.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 19.2.22.
//

import Foundation

enum FridgeErrors: Error {
    case grabFailed
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
