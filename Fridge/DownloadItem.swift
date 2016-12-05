//
//  DownloadItem.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 1.12.16.
/*
MIT License

Copyright (c) 2016 Veljko Tekelerović

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

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
