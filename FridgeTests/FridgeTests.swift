//
//  FridgeTests.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 27.12.16.
//
//

import XCTest
import Foundation
//@testable import Fridge

class FridgeTests : XCTestCase {
    
    //shared mocup objects :
    var fi = try! FridgeItem(withString: "http://httpbin.org/get")
    let sharedFridge = Fridge.shared
    
    let globalTimeoutSeconds : TimeInterval = TimeInterval(7)
    
    func testCanDownloadItem(){
        let testExpectation = expectation(description: "Fridge can download item")
        
        fi.onComplete = { object in
            XCTAssertNotNil(object, "Fridge item is not downloaded")
            testExpectation.fulfill()
        }
        fi.onFailure = { (err) in
            print("Error : \(err)")
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (err) in
            XCTAssertNil(err, "Error during download")
        }
    }
    
    func testFridgeCallsOnCompleteClosure() {
        let expect = expectation(description: "Fridge can call onComplete() closure")
        
        fi.onComplete = { (someObject) in
            XCTAssertNotNil(someObject, "Download object is NIL after download")
            expect.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (err) in
            XCTAssertNil(err, "Fridge doesn't call onComplete() closure")
        }
    }
    
    func testFridgeGracefullyFails() {
        let expect = expectation(description: "Fridge can fail gracefully")
        fi.downloadDestination = URL(string: "/Users/vexy/non_existing_folder")!
        
        fi.onFailure = { (error) in
            
            print("Error is : \(error)")
            XCTAssertNotNil(error, "An error is thrown")
            
            expect.fulfill()
        }
        
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (someErr) in
            XCTAssertNil(someErr)
        }
    }
    
    func testFridgeDownloadsToCachesDirectory() {
        let test_expect = expectation(description: "Fridge can download to Caches directory")
        
        let fridgeCacheFolder = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/Fridge/"
        
        fi.onComplete = { (object) in
            let validator = fridgeCacheFolder.appending(object.lastPathComponent)
            
            //check if object is located at Fridge.systemCacheDirectory
            XCTAssertTrue(FileManager.default.fileExists(atPath: validator))
            test_expect.fulfill()
        }
        
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (someErr) in
            XCTAssertNil(someErr, "Some error raised during downloading an item to Fridge cache")
        }
    }
    
    func testFridgeDownloadsToDesiredLocation() {
        let expect = expectation(description: "Fridge places item in desired location path")
        
        let path = "/Users/vexy/Desktop/Fridge/"
        fi.downloadDestination = URL(fileURLWithPath: path)
        
        fi.onComplete = { (object) in
            //check if an item exists at this location
            let boolResult : Bool = FileManager.default.fileExists(atPath: object.path)
            
            XCTAssertTrue(boolResult)
            expect.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (error) in
            XCTAssertNil(error)
        }
    }
}
