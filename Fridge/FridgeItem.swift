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
struct FridgeItem {
    private var defaultURL = URL(string: "http://www.google.com")!
    
    var url : URL {
        didSet {
            guard url.scheme != nil, isValidScheme(url.scheme!) else {
                print("URL is \(url.description), which is not appropriate. Defaulting...")
                self.url = defaultURL
                return
            }
        }
    }
    
    var downloadDestination : URL?
    
    var onComplete : success = {_ in return}
    var onFailure : failure = {_ in return}
    
    init() {
        url = defaultURL
    }
    
    init(withURL u : URL?) throws {
        //guard against 'empty' URL
        guard u != nil else { throw FridgeError.generalError }
        
        //default assignment first !
        url = u ?? URL(string: "http://www.google.com")!
        
        if let sch = u?.scheme {
            if !isValidScheme(sch) {
               throw FridgeError.invalidScheme
            }
        } else {
            throw FridgeError.invalidScheme
        }
    }
    
    init(withString s : String) throws {
        url = defaultURL   //assign default value first !
        
        //check if we have valid scheme for this string
        guard isValidScheme(s) else {
            throw FridgeError.invalidScheme
        }
        
        //finally :
        url = URL(string: s)!
    }
    
    private func isValidScheme(_ scheme : String) -> Bool {
        return (scheme.contains("http") || scheme.contains("https"))
    }
}
