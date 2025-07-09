//
//  Errors.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 19.2.22.
//

import Foundation

enum FridgeErrors: Error {
    case networkingIssues(reason: String)
    case storageIssues(reason: String)
    case decodingIssues(reason: String)
    case invalidIdentifier
}
