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
    
    func testFridgeDownloadsToDesiredLocation_ThatExist() {
        let expect = expectation(description: "Fridge places item in custom location path that exists")
        
        //because tests will be executed on CI, make sure we have test directory
        do {
            fi.downloadDestination = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Fridge", isDirectory: true)
        } catch {
            print("TESTS : Unable to create test directory !!")
        }
        
        print("TESTS: custom download destination is : \(fi.downloadDestination!.path)")
        
        fi.onComplete = { (object) in
            //check if an item exists at this location
            let boolResult : Bool = FileManager.default.fileExists(atPath: object.path)
            
            XCTAssertTrue(boolResult, "Downloaded file isn't copied to custom location")
            expect.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testFridgeDownloadsToDesiredLocation_ThatDontExist() {
        let expect = expectation(description: "Fridge defaults to FridgeCache if using non existing custom destination")
        
        fi.downloadDestination = URL(string: "/some/non_existing_folder/")
        
        fi.onComplete = { (object) in
            //check if an item exists at this location
            let boolResult : Bool = FileManager.default.fileExists(atPath: object.path)
            
            XCTAssertTrue(boolResult, "Downloaded file isn't copied to Fridge cache after it is instructed to download item to non-existing custom folder")
            expect.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (error) in
            XCTAssertNil(error)
        }
    }
}
