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
    
    //declaration of mock objects :
    //Strings
    let emptyString               = ""
    let randomString              = "someRandomString (lsaidh 129418ycs clihrq)"
    let otherThanHTTPSchemeString = "ftp://foo.at.bar/folder"
    //
    let validator                 = "https://www.google.com"
    
    
    //URL's
    let validURL =   URL(string: "http://www.apple.com")!
    let fakeURL  =   URL(string: "someFakeURL_initializedWithString")!
    let nillURL  =   URL(string: "")          //will make this let an optional !!!
    
    
    //FRIDGE item
    var fi = FridgeItem()
    
    
    //MARK:- Tests of object initializers that accept 'String'
    func testInitWithEmptyStringThrows() {
        XCTAssertThrowsError(_  = try FridgeItem(withString: emptyString))
    }
    
    func testInitWithRandomStringThrows() {
        XCTAssertThrowsError(_ = try FridgeItem(withString: randomString))
    }
    
    func testInitWithFTPStringThrows() {
        XCTAssertThrowsError(_ = try FridgeItem(withString: otherThanHTTPSchemeString))
    }
    
    func testInitWithValidStringDontThrow() {
        do {
            _ = try FridgeItem(withString: validator)
        } catch {
            XCTFail("Regular URL item throws error !")
        }
    }
    
    
    //MARK:- Test of object initializers that accept 'URL'
    func testInitWithValidURLPasses() {
        fi = try! FridgeItem(withURL: validURL)
        
        XCTAssert(fi.url.absoluteString == validURL.absoluteString, "Valid URL object isn't assigned to struct property !")
    }
    
    func testInitWithFakeURLThrows() {
        XCTAssertThrowsError( _ = try FridgeItem(withURL: fakeURL) )
    }
    
    func testInitWithNillURLThrows() {
        XCTAssertThrowsError( _ = try FridgeItem(withURL: nillURL))
    }
    
    func testInitWithFakeURLResetsToDefaultValue() {
        do {
            fi = try FridgeItem(withURL: fakeURL)
            
        } catch FridgeError.invalidScheme {
            XCTAssertFalse(fi.url.absoluteString == validator, "Initialization with fake URL doesn't reset value !")
        } catch {
            XCTFail("Something is thrown!")
        }
    }
    
    func testInitWithNilURLResetsToDefaultValue() {
        do {
            fi = try FridgeItem(withURL: nillURL)
        } catch FridgeError.generalError {
            XCTAssertFalse(fi.url.absoluteString == validator, "Initialization with nil URL doesn't reset value")
        } catch {
            XCTFail("Something is thrown!")
        }
    }
    
    
    //MARK:- URL Assignments test
    func testAssignInvalidURLSchemeResetsToDefaultsValue() {
        fi.url = URL(string: otherThanHTTPSchemeString)!
        
        XCTAssertFalse(fi.url.absoluteString == validator, "Assigning URL with invalid scheme does not defaults property !")
    }
    
    func testAssignFakeURLDefaultsResetsToDefaultValue() {
        fi.url = fakeURL
        
        XCTAssertFalse(fi.url.absoluteString == fakeURL.absoluteString, "Assigning fake URL doesn't default property !")
    }
    
}
