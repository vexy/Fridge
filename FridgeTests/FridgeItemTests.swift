//
//  FridgeTests.swift
//  FridgeTests
//
//  Created by Veljko Tekelerovic on 21.12.16.
//
//

import XCTest
import Darwin

class FridgeItemTests: XCTestCase {
    
    func testEmptyStringThrows() {
        XCTAssertThrowsError(_  = try FridgeItem(withString: ""))
    }
    
    func testRandomStringThrows() {
        XCTAssertThrowsError(_ = try FridgeItem(withString: "someString"))
    }
    
    func testFTPStringThrows() {
        XCTAssertThrowsError(_ = try FridgeItem(withString: "ftp://foo.bar"))
    }
    
    func testValidStringPasses() {
        do {
            _ = try FridgeItem(withString: "https://www.google.com")
        } catch {
            XCTFail("Regular URL item throws error !")
        }
    }
    
    func testFakeURLObject() {
        let fake = URL(string: "someString")
        let t = FridgeItem(withURL: fake)
        
        XCTAssert(t.url.absoluteString == fake!.absoluteString)
    }
}
