/*
                *   FRIDGE TESTS    *

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

final class FridgeTests: XCTestCase {
    /// Tests weather Fridge can save the object from the surface level
    func testCanFreezeObject() throws {
        let testObject = FridgeMockObject()
        try Fridge.freeze🧊(testObject, id: STORAGE_IDENTIFIER)
    }
    
    /// Tests weather Fridge can load the object from the surface level
    func testCanUnfreeeObject() throws {
        let retrievedObject: FridgeMockObject = try Fridge.unfreeze🪅🎉(STORAGE_IDENTIFIER)
        XCTAssert(retrievedObject.string_field == "Some f🧊ncy string")
        XCTAssert(retrievedObject.int_field == Int.max)
        XCTAssert(retrievedObject.arr_field[0] == 0xA)
        XCTAssert(retrievedObject.arr_field[1] == 0xB)
        XCTAssert(retrievedObject.arr_field[2] == 0xC)
    }
    
    func testThrowsOnInvalidIdentifier() {
        do {
            let _: String = try Fridge.unfreeze🪅🎉("some.non.existing.key")
            XCTFail("Should'ev failed")
        } catch { }
    }

//MARK:-
    /*
        Make sure Fridge can greet fellow programmers
    */
    func testAmIInsane🤔() {
        //let's see...
        Fridge.greetFellowProgrammers🤠()
        XCTAssertTrue(true == true)     ///🤯
        
        /*
            Dear reader,
            If you prove that :
         
            Exactly one commit after d46bff5c504561ade2a45403b698775a8d55c048
            "Fridge doesn't have 100% test coverage" -
            please reach back to Fridge author to claim your FREE
         
            Cheers !
            🍻🍻🍻
        */
    }
    
    override class func tearDown() {
        //just dump used storage
        Fridge.drop🗑(STORAGE_IDENTIFIER)
        print("\n** <Fridge.Tests> Test object removed from the file system **\n")
    }
}
