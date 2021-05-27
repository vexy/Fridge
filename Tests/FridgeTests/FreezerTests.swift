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


import XCTest
import Foundation
@testable import Fridge

final class FreezerTests: XCTestCase {
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
        XCTAssertNoThrow(try freezer.freeze(object: testData1))
    }
    
    func testFreezingAnArray() throws {
        let testArray = [TestingStructure]()
        try freezer.freeze(object: testArray)
    }
    
    func testUnfreezingCapability() {
        //freeze an object first
        var frozenObject = TestingStructure()
        frozenObject.field1 = 10
        XCTAssertNoThrow(try freezer.freeze(object: frozenObject))
        
        do {
            //unfreeze it now
            let unFrozenObject: TestingStructure = try freezer.unfreeze()
            
            //make sure they are equal
            XCTAssert(frozenObject == unFrozenObject)
        } catch {
            XCTFail("Unable to unfeeze frozen object")
        }
    }
    
    func testSuccessiveFreeze() throws {
        var data1 = TestingStructure(); data1.field1 = -100
        var data2 = TestingStructure(); data2.field2 =  100
        
        //freeze both objects (in specific order)
        try freezer.freeze(object: data1)
        try freezer.freeze(object: data2)
        
        //now try to pull put data1 first
        let pulledData: TestingStructure = try freezer.unfreeze()
        // test consistency
        XCTAssert(pulledData != data1)
    }
    
    func testFreezingPersistance() throws {
        #warning("Incomplete test")
        let testData1 = TestingStructure()
        
        //freeze first
        try freezer.freeze(object: testData1)
        
        //check if it's present
        XCTAssertFalse(freezer.isAlreadyFrozen(object: testData1))
    }
    
    static var allTests = [
        ("testFreezingCapability", testFreezingCapability),
        ("testUnfreezingCapability", testUnfreezingCapability),
        ("testSuccessiveFreeze", testSuccessiveFreeze),
        ("testFreezingPersistance", testFreezingPersistance)
    ]
}
