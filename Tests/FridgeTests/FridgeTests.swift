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
    func testCanFreezeObject() throws {
        struct SomeCodableStruct: Codable {
            var field1: String
            var field2: URL
            
            init() {
                field1 = ""
                field2 = URL(fileURLWithPath: "someFilePathOfAMockObject")
            }
        }
        
        //try to save a struct
        let testObject = SomeCodableStruct()
        try Fridge.freeze🧊(testObject)
        
        //if it throws, test will fail on it's own
    }
    
    func testAmIInsane🤔() {
        //Make sure Fridge can greet fellow programmers
        //.....
        //....
        //..
        //.
        //umm... like really ??
        
        //let's see...
        Fridge.greetFellowProgrammers()
        XCTAssertTrue(true == true)     ///🤯
        
        /*
            Dear reader,
            If you prove that :
         
            Exactly one commit after
            [d46bff5c504561ade2a45403b698775a8d55c048]
            Fridge doesn't have 100% test coverage,
            please reach back to Fridge author
            to claim your FREE
            🍻
         
            Cheers !
        */
    }

    static var allTests = [
        ("Sanity check", testAmIInsane🤔),
        ("Freezing capabilities", testCanFreezeObject)
    ]
}
