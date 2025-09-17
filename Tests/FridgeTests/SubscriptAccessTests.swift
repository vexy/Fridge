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

//
//  SubscriptAccessTests.swift
//  Fridge
//
//  Created by Veljko on 9/17/25.
//

import Testing
import Fridge

@Suite("Subscript notation tests")
struct SubscriptAccessTests : ~Copyable{
    let mockObject: FridgeMockObject

    // freeze a testing object each test
    init() throws {
        mockObject = FridgeMockObject()
        try Fridge.freeze🧊(mockObject, id: STORAGE_IDENTIFIER)
    }

    @Test("Unfreezing works without throwing")
    func doesntThrowUsingSubscript() {
        #expect(throws: Never.self) {
            let _: FridgeMockObject = try Fridge[STORAGE_IDENTIFIER]
        }
    }

    @Test("Unfreezing using subscript notation")
    func canUnfreeWithSubscript() throws {
        let frozenObject: FridgeMockObject = try Fridge[STORAGE_IDENTIFIER]

        #expect(frozenObject.string_field == "Some f🧊ncy string")
        #expect(frozenObject.int_field == Int.max)
        #expect(frozenObject.arr_field[0] == 0xA)
        #expect(frozenObject.arr_field[1] == 0xB)
        #expect(frozenObject.arr_field[2] == 0xC)
        #expect(frozenObject.bool_field == false)
    }

    @Test("Throws on invalid identifier (using subscripts)")
    func throwsOnInvalidSubscript() {
        #expect(throws: (any Error).self) {
            let _: FridgeMockObject = try Fridge["non.existing.identifier"]
        }
    }
}
