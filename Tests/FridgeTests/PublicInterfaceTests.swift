//
//  PublicInterfaceTests.swift
//  Fridge
//
//  Created by Veljko on 9/17/25.
//
import Testing
import Fridge

@Suite(.serialized)
struct PublicInterfaceTests {
    var testObject: FridgeMockObject

    init() {
        testObject = FridgeMockObject()
    }

    @Test("Codable object can be frozen")
    func canFreezeObject() throws {
        #expect(throws: Never.self) {
            try Fridge.freeze🧊(testObject, id: STORAGE_IDENTIFIER)
        }
    }

    @Test("Frozen object can be unfrozen")
    func canUnfreeObject() throws {
        var retrievedObject: FridgeMockObject = FridgeMockObject()

        #expect(throws: Never.self) {
            retrievedObject = try Fridge.unfreeze🪅🎉(STORAGE_IDENTIFIER)
        }

        #expect(retrievedObject.string_field == "Some f🧊ncy string")
        #expect(retrievedObject.int_field == Int.max)
        #expect(retrievedObject.arr_field[0] == 0xA)
        #expect(retrievedObject.arr_field[1] == 0xB)
        #expect(retrievedObject.arr_field[2] == 0xC)
    }

    @Test("Throws on invalid identifier")
    func throwsOnInvalidIdentifier() throws {
        #expect(throws: (any Error).self) {
            let _: String = try Fridge.unfreeze🪅🎉("some.non.existing.key")
        }
    }

    @Test("Fridge.isFrozen method works properly")
    func isFrozen_knownIdentifier() {
        #expect(Fridge.isFrozen🔬(STORAGE_IDENTIFIER) == true)
    }

    @Test("Fridge.isFrozen method works properly for unknown identifiers")
    func isFrozen_unknownIdentifier() {
        #expect(Fridge.isFrozen🔬("some.unknown.identifier") == false)
    }

    @Test("Dropped object cannot be unfrozen")
    func droppingObject() throws {
        // drop a testing object
        Fridge.drop🗑(STORAGE_IDENTIFIER)

        // expect failure on next attempt to unfreeze it
        #expect(throws: (any Error).self) {
            let _: FridgeMockObject = try Fridge.unfreeze🪅🎉(STORAGE_IDENTIFIER)
        }
    }

    @Test("Fridge can greet fellow programmers 🙌")
    func fridgeCanGreet() {
        Fridge.greetFellowProgrammers🤠()
        #expect(1 == 1) /// 🤷🏻‍♂️
        /*
            Dear reader,
            If you prove that :

            Exactly one commit after d46bff5c504561ade2a45403b698775a8d55c048
            "Fridge doesn't have 100% test coverage" -
            please reach back to Fridge author to claim your FREE 🍺

            Cheers !
            🍻🍻🍻
        */
    }
}
