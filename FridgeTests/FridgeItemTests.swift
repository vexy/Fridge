//
//  FridgeTests.swift
//  FridgeTests
//
//  Created by Veljko Tekelerovic on 21.12.16.
//
//

import XCTest
//@testable import FridgeItem

class FridgeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEmptyString() {
        do {
            _  = try FridgeItem(withString: "")
            
            XCTFail("Empty FridgeItem does not throws !")
        } catch {
            XCTAssert(1 == 1, "Fail in throwing clause")
        }
    }
    
    func testInvalidFridgeItemThrows() {
        do {
            _ = try FridgeItem(withString: "someString")
            
            XCTFail("Invalid string items does not throw")
        } catch {
            XCTAssert(1 == 1)
        }
    }
    
    func testValidFridgeItemPasses() {
        do {
            let itm = try FridgeItem(withString: "http://www.google.com")
            let tempUrl = URL(string: "http://www.google.com")!
            
            XCTAssert(itm.url == tempUrl, "Valid https scheme was unable to process !")
        } catch {
            XCTAssert(1 == 1)
        }
    }
}
