//
//  SubscriptTests.swift
//  
//
//  Created by Veljko Tekelerovic on 20.12.23.
//

import XCTest
import Foundation

@testable import Fridge

final class CustomSubscriptTests: XCTestCase {
    private func freezeTestObject() throws {
        let testObject = FridgeMockObject()
        try Fridge.freeze🧊(testObject, id: STORAGE_IDENTIFIER)
    }
    
    func testInvalidIdentifierThrows_UsingSubscript() {
        do {
            let _ : FridgeMockObject = try Fridge["non_existant_id"]
            XCTFail("Should'ev thrown an error")
        } catch let err as FridgeErrors {
            print("** Fridge error raised: ", err)
        } catch let generalError {
            print("General error is: ", generalError)
        }
    }
    
    func testCanUnFreee_UsingSubscript() throws {
        try freezeTestObject()

        let frozenObject: FridgeMockObject = try Fridge[STORAGE_IDENTIFIER]
        
        XCTAssert(frozenObject.string_field == "Some f🧊ncy string")
        XCTAssert(frozenObject.int_field == Int.max)
        XCTAssert(frozenObject.bool_field == false)
    }
    
    override class func tearDown() {
        Fridge.drop🗑(STORAGE_IDENTIFIER)
        print("\n** <Fridge.Tests> Test object removed from the file system **\n")
    }
}
