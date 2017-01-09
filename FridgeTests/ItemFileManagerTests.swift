//
//  ItemFileManagerTests.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 28.12.16.
//
//

import Foundation
import XCTest

class ItemFileMangerTests : XCTestCase {
    //shared mockup objects
    let f = Fridge.shared
    var fi = FridgeItem()
    let sourceMock = URL(string: "someNotImportantURL")!
    
    func testCanCopyToDestinationAfterDownload() {
        let expect = expectation(description: "Fridge can copy downloaded file to destination after download")
        
        fi.url = URL(string: "http://www.bigfoto.com/dog-animal.jpg")!
        fi.downloadDestination = URL(fileURLWithPath: "/Users/vexy/Desktop/Fridge/")
        fi.onComplete = { (photo) in
            //photo is our destination, we should inspect if it matches desired directory
            let operationPath = photo.path
            let validatorPath = self.fi.downloadDestination!.appendingPathComponent("dog-animal.jpg").path

            XCTAssertEqual(operationPath, validatorPath)
            
            expect.fulfill()
        }
        
        f.download(item: fi)
        
        waitForExpectations(timeout: 10) { (err) in
            XCTAssertNil(err, "Unable to copy FridgeItem to destination")
        }
    }
    
    //MARK:- These test's will not work if constructFileName function is not public function
    func testFileNameConstruction_RegularURL() {
        fi.url = URL(string: "http://www.bigfoto.com/dog-animal.jpg")!
        let p = ItemFileManger(file: fi, source: sourceMock)
        
        let fileName = p.constructFileName()
        
        XCTAssertEqual(fileName, "dog-animal.jpg")
    }
    
    func testFileNameConstruction_DomainURL() {
        fi.url = URL(string: "http://someDomain.com")!
        let p = ItemFileManger(file: fi, source: sourceMock)
        
        let fileName = p.constructFileName()
        
        XCTAssertNotEqual(fileName, "someDomain.com")
    }
    
    func testFileNameConstruction_HTTPResponse_OR_NakedURL() {
        fi.url = URL(string: "http://httpbin.org/headers")!
        let p = ItemFileManger(file: fi, source: sourceMock)
        
        let fileName = p.constructFileName()
        
        print("TESTS : fileName is = \(fileName)")
        
        XCTAssertNotEqual(fileName, "naked")
    }
    
    func testFileNameConstruction_WithFragmentURL() {
        //TESTS AS PER FRAGMENT RFC3986 specifications (https://tools.ietf.org/html/rfc3986)
        let fragment1 = URL(string: "http://www.example.org/foo.html#bar")!
        let fragment2 = URL(string: "http://example.com/bar.webm#t=40,80&xywh=160,120,320,240")!
        let fragment3 = URL(string: "https://pypi.python.org/zodbbrowser-0.3.1.tar.gz#md5=38dc89f294b24691d3f0d893ed3c119c")!
        let fragment4 = URL(string: "http://example.com/page?query#!state")!    //GOOGLE FRAGMENT
        let fragment5 = URL(string: "http://example.com/index.html#!s3!open_items")!
        let fragment6 = URL(string: "http://example.com/document.txt#match=[rR][fF][cC]")!
        let fragment7 = URL(string: "http://example.com/index.html#:words:some-context-for-a-(search-term)")!
        let fragment8 = URL(string: "http://example.com/index.html#115Fragm8+-52f89c4c")!
        
        //prepare fragment arrays
        let allFragments : [URL] = [fragment1, fragment2, fragment3, fragment4, fragment5, fragment6, fragment7, fragment8]
        let validator : [String] = ["foo.bar", "bar.webm", "zodbbrowser-0.3.1.tar.gz", "someUDIDString", "index.html", "document.txt", "index.html", "index.html"  ]
        
        //cycle through all fragments
        for i in 1..<allFragments.count {
            fi.url = allFragments[i]
            let p = ItemFileManger(file: fi , source: sourceMock)
            
            let fileName = p.constructFileName()
            
            //Google fragment URL will be translated to some UDID string ;
            //test against original filename
            if i == 3 {
                XCTAssertNotEqual(fileName, "page")
            } else {
                XCTAssertEqual(fileName, validator[i])
            }
        }
    }
    
    func testFileNameConstruction_MultiDotsFile() {
        fi.url = URL(string: "http://someDomain.tv/getRich/orDieTrying/sabak.ngu.iioa")!
        let p = ItemFileManger(file: fi, source: sourceMock)
        
        let fileName = p.constructFileName()
        
        XCTAssertEqual(fileName, "sabak.ngu.iioa")
    }
}
