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
    
    func testCanCopyToDestination() {
//        let exp = expectation(description: "FileManager can copy item")
        
        let testDestination = URL(fileURLWithPath: "/Users/vexy/Desktop/")
        let fileExample = URL(fileURLWithPath: "/Users/vexy/Desktop/Fridge/get")
        
        let ifm = ItemFileManger(file: fileExample)
        
        do {
            let checker = URL(fileURLWithPath: testDestination.path + "/get.tmp")
            
            let finalPath = try ifm.permaCopy(to: testDestination)
            
            XCTAssertEqual(finalPath.path, checker.path)
        } catch {
            XCTFail()
        }
    }
    
    
    /*
     
     TODO : nastaviti sa testiranjem ove funkcije !!!
            nesto tu nije kako treba
     
            - napraviti 3 razlicita testa
            - koja mogu da objedine sve moguce varijante
 
    */
    func testFileNameConstruction() {
        let someURL = URL(string: "http://someString/get/protect.aas")!
        let p = ItemFileManger(file: someURL)
        
        XCTAssertEqual(p.constructFileName(), "protect.aas")
    }
}
