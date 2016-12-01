//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("WELCOME TO ❄️FRIDGE❄️")


let target = URL(string: "https://www.google.rs")!   //experiment with different soures
var dlo = DownloadableObject(withURL: target)
dlo.onComplete = {
    print("◉ Successfully loaded google.rs website")
}

var dlo1 = DownloadableObject()
dlo1.objectURL = URL(string: "https://www.apple.com")!
dlo1.onComplete = {
    print("◉ Successfully loaded apple.com website")
}

var dlo2 = DownloadableObject()
dlo2.objectURL = URL(string: "https://www.facebook.com")!
dlo2.onComplete = {
    print("◉ Successfully loaded facebook.com website")
}

//create downloader
//let d = Downloader(withObject: dlo)
/*
let d = Downloader(withObjects: [dlo, dlo1, dlo2])
d.download()
*/

let imageFile = DownloadableObject(withURL: URL(string: "http://localhost:8888/images/Red.png")!)
let imageFile2 = DownloadableObject(withURL: URL(string: "http://localhost:8888/images/Blue.png")!)
let imageFile3 = DownloadableObject(withURL: URL(string: "http://localhost:8888/images/Yellow.png")!)
let imageFile4 = DownloadableObject(withURL: URL(string: "http://localhost:8888/images/Violet.png")!)
let imageFile5 = DownloadableObject(withURL: URL(string: "http://localhost:8888/images/Pattern.png")!)

let d1 = Downloader(withObjects: [imageFile, imageFile2, imageFile3, imageFile4, imageFile5])

d1.download()

//hard stop app after 10 seconds...
RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))


