/*
//
//  FreezerTests.swift
//  FridgeTests
//
//  Created by Veljko Tekelerovic on 21.1.20.

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
import XCTest

@testable import Fridge

fileprivate struct FridgeTestObject: Codable {
    let string_field: String
    let int_field: Int
    let dict_field: InnerTestObject
    let arr_field: [Int]
    let data_field: Data
    let url_field: URL
    
    static let IDENTIFIER = "Test.OBJECT"
    
    
    init() {
        string_field = "Some f🧊ncy string"
        int_field = Int.max
        dict_field = InnerTestObject()
        arr_field = [100, 200, 300, Int.random(in: Int.min...Int.max)]
        data_field = Data(repeating: 0xAE, count: 0xABCDEF)
        url_field = URL(fileURLWithPath: "someFilePathOfAMockObject")
    }
}

fileprivate struct InnerTestObject: Codable {
    var field1: Float   = 1_234_567.890_001
    var field2: Double  = Double.pi
    var field3: Set     = Set([1,2,3])
    var field4: String? = nil
}

extension FridgeTestObject: Equatable {
    static func ==(lhs: FridgeTestObject, rhs: FridgeTestObject) -> Bool {
        let equality =
        (lhs.string_field == rhs.string_field) &&
        (lhs.int_field == rhs.int_field) &&
        (lhs.arr_field == rhs.arr_field)
        
        return equality
    }
}

final class FreezerTests: XCTestCase {
    // SHARED TESTING OBJECT
    let freezer = Freezer()
    
    /// Tests weather an object can be saved without throwing error
    func testBasicFreezing(){
        let testData1 = FridgeTestObject()
        XCTAssertNoThrow(try freezer.freeze(object: testData1, identifier: FridgeTestObject.IDENTIFIER))
    }

    /// Tests weather an object can be loaded without throwing error
    func testBasicUnfreezing() {
        //freeze an object first
        let frozenObject = FridgeTestObject()
        
        XCTAssertNoThrow(try freezer.freeze(object: frozenObject, identifier: FridgeTestObject.IDENTIFIER))
        
        do {
            //unfreeze it now
            let unFrozenObject: FridgeTestObject = try freezer.unfreeze(identifier: FridgeTestObject.IDENTIFIER)
            
            //make sure they are equal
            XCTAssert(frozenObject == unFrozenObject)
        } catch {
            XCTFail("Unable to unfeeze frozen object")
        }
    }

    func testPersistancyChecks() {
        XCTAssert(freezer.isAlreadyFrozen(identifier: FridgeTestObject.IDENTIFIER))
        XCTAssertFalse(freezer.isAlreadyFrozen(identifier: "non_existant_object"))
    }
    
    /// Tests if array can be stored
//    func testFreezingAnArray() throws {
//        XCTAssertFalse(freezer.isAlreadyFrozen(identifier: "array.test"))
//
//        let freezingArray = [1,2,3,4,5,6,7,8]
//        let objectArray: Array<FridgeTestObject> = [FridgeTestObject(), FridgeTestObject()]
//        try freezer.freeze(object: freezingArray, identifier: "array.test")
//        try freezer.freeze(object: objectArray, identifier: "array-object.test")
//
//        let unpackedObject: [Int] = try freezer.unfreeze(identifier: "array.test")
//        XCTAssert(unpackedObject[0] == freezingArray[0])
//    }
}
