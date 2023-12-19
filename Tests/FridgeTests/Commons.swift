//
//  Commons.swift
//  
//
//  Created by Veljko Tekelerovic on 19.12.23.
//

import Foundation

let STORAGE_IDENTIFIER = "Fridge.TestObject"

public struct FridgeMockObject: Codable {
    let string_field: String
    let int_field: Int
    let arr_field: [Int]
    let bool_field: Bool
    let data_field: Data
    let url_field: URL
    
    // representation of potential user object (sub)struct
    let dict_field: InnerTestObject
    
    init() {
        string_field = "Some f🧊ncy string"
        int_field = Int.max
        arr_field = [
            0xA,
            0xB,
            0xC,
            Int.random(in: Int.min...Int.max)
        ]
        bool_field = false
        data_field = Data(repeating: 0xAF, count: 0xcaf)
        url_field = URL(fileURLWithPath: "someFilePathOfAMockObject")
        //
        dict_field = InnerTestObject()
    }
}

public struct InnerTestObject: Codable {
    var field1: String?      = nil
    var field2: Float        = 1_234_567.890_001
    var field3: Double       = Double.pi
    var field4: Date         = Date.init()
    var field5: Set          = Set([1,2,3])
    var field6: Array<Int64> = Array.init()
}

extension FridgeMockObject: Equatable {
    public static func ==(lhs: FridgeMockObject, rhs: FridgeMockObject) -> Bool {
        let equality =
        (lhs.string_field == rhs.string_field) &&
        (lhs.int_field == rhs.int_field) &&
        (lhs.arr_field == rhs.arr_field) &&
        (lhs.data_field == rhs.data_field) &&
        (lhs.url_field == rhs.url_field)
        
        //NOTE custom dicts is ommited from equality !!
        // it may be tested separatelly and to full extend of the customization needs

        return equality
    }
}
