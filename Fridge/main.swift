//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("WELCOME TO ❄️FRIDGE❄️")


let target = URL(string: "tps://www.google.rs")!   //experiment with different soures
var dlo = DownloadItem(withURL: target)
dlo.onComplete = { (object) in
    print("◉ Successfully loaded google.rs website")
}

var dlo1 = DownloadItem()
dlo1.itemURL = URL(string: "https://www.apple.com")!
dlo1.onComplete = { (object) in
    print("◉ Successfully loaded apple.com website, downloaded object can be found in : \(object.absoluteString)")
}

var dlo2 = DownloadItem()
dlo2.itemURL = URL(string: "https://www.facebook.com")!
dlo2.onComplete = { (object) in
    print("◉ Successfully loaded facebook.com website")
}

//create downloader
//let d = Downloader(withObject: dlo)
///*
let d = Downloader(withObjects: [dlo, dlo1, dlo2])
d.download()
//*/

//check the throwing init
do {
    let itm = try DownloadItem(withString: "ht//someBadString")
    d.download()
} catch FridgeError.generalError {
    print("✋ Unable to create download item, check your schemes !!")
}

// d.download(object(s))

/*
let imageFile = DownloadItem(withURL: URL(string: "http://localhost:8888/images/Red.png")!)
let imageFile2 = DownloadItem(withURL: URL(string: "http://localhost:8888/images/Blue.png")!)
let imageFile3 = DownloadItem(withURL: URL(string: "http://localhost:8888/images/Yellow.png")!)
let imageFile4 = DownloadItem(withURL: URL(string: "http://localhost:8888/images/Violet.png")!)
let imageFile5 = DownloadItem(withURL: URL(string: "http://localhost:8888/images/Pattern.png")!)

let d1 = Downloader(withObjects: [imageFile, imageFile2, imageFile3, imageFile4, imageFile5])

d1.download()
 */

//hard stop app after 10 seconds...
RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))


