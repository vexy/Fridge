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

// !! LET THE HUNT BEGIN !! 🕵️‍♂️🥷
final class FreezerTests: XCTestCase {
    // SHARED TESTING OBJECT
    let freezer = Freezer()
    
    let FOUNDATION_ID   = "foundation.array"
    let CUSTOM_ARRAY_ID = "custom.array"
    let NON_EXISTANT_ID = "non_existant_object"
    
    /// Tests weather an object can be saved without throwing error
    func testObjectFreezing(){
        let testData = FridgeMockObject()
        XCTAssertNoThrow(try freezer.freeze(object: testData, identifier: STORAGE_IDENTIFIER))
    }

    /// Tests weather an object can be loaded without throwing error
    func testObjectUnfreezing() {
        //freeze an object first
        let frozenObject = FridgeMockObject()
        
        XCTAssertNoThrow(try freezer.freeze(object: frozenObject, identifier: STORAGE_IDENTIFIER))
        
        do {
            //unfreeze it now
            let unFrozenObject: FridgeMockObject = try freezer.unfreeze(identifier: STORAGE_IDENTIFIER)
            
            //make sure they are equal
            XCTAssert(frozenObject == unFrozenObject)
        } catch {
            XCTFail("Unable to unfeeze frozen object")
        }
    }

    func testPersistancyChecks() {
        XCTAssert(freezer.isAlreadyFrozen(identifier: STORAGE_IDENTIFIER))
        XCTAssertFalse(freezer.isAlreadyFrozen(identifier: NON_EXISTANT_ID))
    }
    
    /// Tests if array can be stored and read from the storage
    func testArrayFridging() throws {
        let foundationArray = [1,2,3,4,5,6,7,8]
        let customStructArray: Array<FridgeMockObject> = [FridgeMockObject(), FridgeMockObject()]
        
        // try to freeze these arrays
        XCTAssertNoThrow(try freezer.freeze(objects: foundationArray, identifier: FOUNDATION_ID))
        XCTAssertNoThrow(try freezer.freeze(objects: customStructArray, identifier: CUSTOM_ARRAY_ID))
        
        // now try to unfreeze
        do {
            // check foundation
            let unfrozenFoundation: Array<Int> = try freezer.unfreeze(identifier: FOUNDATION_ID)
            XCTAssert(foundationArray == unfrozenFoundation)
            
            // custom struct
            let unfrozenCustomArray: Array<FridgeMockObject> = try freezer.unfreeze(identifier: CUSTOM_ARRAY_ID)
            XCTAssert(customStructArray[0] == unfrozenCustomArray[0])
        } catch {
            XCTFail("Unable to Fridge arrays...")
        }
    }
}
