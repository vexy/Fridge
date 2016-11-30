//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("About to start downloading Fridge items")


let target = URL(string: "https://www.google.rs")   //experiment with different soures
var dlo = DownloadableObject(withURL: target!)
dlo.onComplete = {
    print("<Main.swift> Download of this object completed, called onComplete()")
}

//create downloader
let d = Downloader(withObject: dlo)
d.download()

//RunLoop.main.run()

RunLoop.main.run(until: Date(timeIntervalSinceNow: 15))


