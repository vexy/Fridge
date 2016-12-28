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
    
    let globalTimeoutSeconds : TimeInterval = TimeInterval(5)
    
    func testCanDownloadItem(){
        let testExpectation = expectation(description: "Fridge can download item")
        
        fi.onComplete = { object in
            XCTAssertNotNil(object, "Fridge item is not downloaded")
            testExpectation.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (err) in
            XCTAssertNil(err, "Error during download")
        }
    }
    
    func testFridgeCallsOnCompleteClosure() {
        let expect = expectation(description: "Fridge can call onComplete() closure")
        
        fi.onComplete = { _ in
            print("On complete closure called")
//            XCTAssertNotNil(downloadedObject, "Download object is NIL after download")
            expect.fulfill()
        }
        sharedFridge.download(item: fi)
        
        waitForExpectations(timeout: globalTimeoutSeconds) { (err) in
            XCTAssertNil(err, "Fridge doesn't call onComplete() closure")
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
