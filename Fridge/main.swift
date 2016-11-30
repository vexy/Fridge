//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("WELCOME TO FRIDGE")


let target = URL(string: "https://www.google.rs")   //experiment with different soures
var dlo = DownloadableObject(withURL: target!)
dlo.onComplete = {
    print("Successfully loaded google.rs website")
}

var dlo1 = DownloadableObject()
dlo1.objectURL = URL(string: "https://www.apple.com")!
dlo1.onComplete = {
    print("Successfully loaded apple.com website")
}

var dlo2 = DownloadableObject()
dlo2.objectURL = URL(string: "https://www.facebook.com")!
dlo2.onComplete = {
    print("Successfully loaded facebook.com website")
}

//create downloader
//let d = Downloader(withObject: dlo)
let d = Downloader(withObjects: [dlo, dlo1, dlo2])
d.download()

//hard stop app after 20 seconds...
RunLoop.main.run(until: Date(timeIntervalSinceNow: 15))


