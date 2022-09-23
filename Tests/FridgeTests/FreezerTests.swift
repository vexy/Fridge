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
        arr_field = [0xABCDEF, 0xCAB0CAB, 0xFADE, 0xEFCAD]
        data_field = Data(repeating: 0xAE, count: 0xE1FE1)
        url_field = URL(fileURLWithPath: "someFilePathOfAMockObject")
    }
}

fileprivate struct InnerTestObject: Codable {
    var field1: String?      = nil
    var field2: Float        = 1_234_567.890_001
    var field3: Double       = Double.pi
    var field4: Date         = Date.init()
    var field5: Bool         = !false
    
    var field6: Set          = Set([1,2,3])
    var field7: Array<Int64> = Array.init()
}

extension FridgeTestObject: Equatable {
    static func ==(lhs: FridgeTestObject, rhs: FridgeTestObject) -> Bool {
        let equality =
        (lhs.string_field == rhs.string_field) &&
        (lhs.int_field == rhs.int_field) &&
        (lhs.arr_field == rhs.arr_field) &&
        (lhs.data_field == rhs.data_field) &&
        (lhs.url_field == rhs.url_field)
        
        return equality
    }
}

// !! LET THE HUNT BEGIN !! 🕵️‍♂️🥷
final class FreezerTests: XCTestCase {
    // SHARED TESTING OBJECT
    let freezer = Freezer()
    
    /// Tests weather an object can be saved without throwing error
    func testObjectFreezing(){
        let testData = FridgeTestObject()
        XCTAssertNoThrow(try freezer.freeze(object: testData, identifier: FridgeTestObject.IDENTIFIER))
    }

    /// Tests weather an object can be loaded without throwing error
    func testObjectUnfreezing() {
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
    func testArrayFreezing() throws {
        XCTAssertFalse(freezer.isAlreadyFrozen(identifier: "array.test"))

        let foundationArray = [1,2,3,4,5,6,7,8]
        let customStructArray: Array<FridgeTestObject> = [FridgeTestObject(), FridgeTestObject()]
        XCTAssertNoThrow(try freezer.freeze(objects: foundationArray, identifier: "foundation.array"))
        XCTAssertNoThrow(try freezer.freeze(objects: customStructArray, identifier: "array-object.test"))
        
        // make sure it actually throws when passed incorrectly
        XCTAssertThrowsError(try freezer.freeze(object: foundationArray, identifier: "wrong.method.array"))
        XCTAssertThrowsError(try freezer.freeze(object: customStructArray, identifier: "wrong.method.custom.array"))
    }
    
    /// Tests if array can be read from the storage
    func testArrayUnFreezing() throws {
        let expectedFoundationArray = [1,2,3,4,5,6,7,8]
        let expectedStructArray: Array<FridgeTestObject> = [FridgeTestObject(), FridgeTestObject()]
        var failureMessage: String
        
        do {
            // check foundation
            failureMessage = "Foundation array issue"
            let unfrozenFoundation: Array<Int> = try freezer.unfreeze(identifier: "foundation.array")
            XCTAssert(unfrozenFoundation == expectedFoundationArray)
            
            failureMessage = "Array of custom struct issue"
            let unfrozenCustomArray: Array<FridgeTestObject> = try freezer.unfreeze(identifier: "array-object.test")
            XCTAssert(unfrozenCustomArray[0] == expectedStructArray[0])
//            XCTAssert(unfrozenCustomArray[0].dict_field == expectedStructArray[0].dict_field)
        } catch {
            XCTFail(failureMessage)
        }
    }
}
