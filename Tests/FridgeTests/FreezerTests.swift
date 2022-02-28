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

final class FreezerTests: XCTestCase {
    let testObjectIdentifier = "Test.OBJECT"
    struct TestingStructure: Codable, Equatable {
        var field1: Int = 1
        var field2: Int = 2
        
        static func ==(lhs: TestingStructure, rhs: TestingStructure) -> Bool {
            return (lhs.field1 == rhs.field1) && (lhs.field2 == rhs.field2)
        }
    }
    
    // TESTING OBJECT
    let freezer = Freezer()
    
    func testFreezingCapability(){
        let testData1 = TestingStructure()
        //try to save data without throwing
        XCTAssertNoThrow(try freezer.freeze(object: testData1, identifier: testObjectIdentifier))
    }
    
    // Make sure the to test freezing of arrays
//    func testFreezingAnArray() throws {
//        let testArray = [TestingStructure]()
//        try freezer.freeze(object: testArray, identifier: testObjectIdentifier)
//    }
    
    func testUnfreezingCapability() {
        //freeze an object first
        var frozenObject = TestingStructure()
        frozenObject.field1 = 10
        XCTAssertNoThrow(try freezer.freeze(object: frozenObject, identifier: testObjectIdentifier))
        
        do {
            //unfreeze it now
            let unFrozenObject: TestingStructure = try freezer.unfreeze(identifier: testObjectIdentifier)
            
            //make sure they are equal
            XCTAssert(frozenObject == unFrozenObject)
        } catch {
            XCTFail("Unable to unfeeze frozen object")
        }
    }
    
    func testMultipleFreeze() throws {
        var test_structure1 = TestingStructure(); test_structure1.field1 = -100
        var test_structure2 = TestingStructure(); test_structure2.field2 =  100
        
        //freeze both objects (in specific order)
        try freezer.freeze(object: test_structure1, identifier: "data1")
        try freezer.freeze(object: test_structure2, identifier: "data2")
        
        //now try to pull put data1 first
        let pulledData1: TestingStructure = try freezer.unfreeze(identifier: "data1")
        // test consistency
        XCTAssert(pulledData1 == test_structure1)
        XCTAssert(pulledData1.field1 == -100)
        
        //now try to pull put data2
        let pulledData2: TestingStructure = try freezer.unfreeze(identifier: "data2")
        // test consistency
        XCTAssert(pulledData2 == test_structure2)
        XCTAssert(pulledData2.field2 == 100)
    }
    
    func testFreezingPersistance() throws {
        let testData1 = TestingStructure()
        
        //freeze first
        try freezer.freeze(object: testData1, identifier: testObjectIdentifier)
        
        //check if it's present
        XCTAssert(freezer.isAlreadyFrozen(identifier: testObjectIdentifier))
    }
    
    func testNonExistantFreezePersistance() {
        XCTAssertFalse(freezer.isAlreadyFrozen(identifier: "non_existant_object"))
    }
    
//    static var allTests = [
//        ("testFreezingCapability", testFreezingCapability),
//        ("testUnfreezingCapability", testUnfreezingCapability),
//        ("testMultipleFreeze", testMultipleFreeze),
//        ("testFreezingPersistance", testFreezingPersistance)
//    ]
}
