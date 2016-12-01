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

struct DownloadItem {
    var itemURL : URL
    var onComplete : success = {_ in return}
    var onFailure : failure = {_ in return}
    
    init() {
        itemURL = URL(string: "https://www.google.com")!
    }
    
    init(withURL u : URL) {
        itemURL = u
    }
    
    init(withString s : String) throws {
        //check if we have valid scheme for this string
        //valid schemes : http and https
        
        if s.contains("http") || s.contains("https") {
            itemURL = URL(string: s)!
        } else {
            throw FridgeError.generalError
        }
    }
}
