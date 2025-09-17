//
//  Test.swift
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
