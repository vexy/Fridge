//
//  FridgeErrors.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 1.12.16.
//
//

import Foundation

/** Collection of errors that can arise during download process */
public enum FridgeError : Error {
    case notEnoughSpace
    case permissionsError
    case generalError
}

//TODO: Add other errors (refactor existing ones)
