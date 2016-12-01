//
//  DownloadItem.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 1.12.16.
//
//

import Foundation


//closure definitions
typealias success = (_ item: URL) -> ()
typealias failure = (_ error : FridgeError) -> ()

/** Represents an item that should be downloaded from internet */
struct DownloadItem {
    var itemURL : URL {
        willSet {
            if let _ = newValue.scheme {
                if !(newValue.scheme!.contains("http") || newValue.scheme!.contains("https")) {
                    assertionFailure("Only http and https schemes are allowed")
                }
            } else {
                assertionFailure("Only http and https schemes are allowed")
            }
        }
    }
    var desiredLocation : URL?
    
    var onComplete : success = {_ in return}
    var onFailure : failure = {_ in return}
    
    init() {
        itemURL = URL(string: "https://www.google.com")!
    }
    
    init(withURL u : URL) {
        itemURL = u
    }
    
    init(withString s : String) throws {
        //check if we have valid scheme for this string ; valid schemes are http and https
        
        if s.contains("http") || s.contains("https") {
            itemURL = URL(string: s)!
        } else {
            throw FridgeError.invalidScheme
        }
    }
}
