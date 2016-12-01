//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("WELCOME TO ❄️FRIDGE❄️")

//initalize shared downloader

do {
//    var item = try DownloadItem(withString: "www.google.com")
    var item = DownloadItem()
    
    item.itemURL = URL(string: "http://www.google.com")!
    item.onComplete = { (object) in
        print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
    }
    item.onFailure = { (error) in
        print("✋ Unable to complete download ! Following error occured \(error.localizedDescription)")
    }
    
    let d = Downloader.shared
    d.download(item: item)
    
    ///*
    let imageFile = try DownloadItem(withString: "http://localhost:8888/images/Red.png")
    let imageFile2 = try DownloadItem(withString: "http://localhost:8888/images/Blue.png")
    let imageFile3 = try DownloadItem(withString: "http://localhost:8888/images/Yellow.png")
    let imageFile4 = try DownloadItem(withString: "http://localhost:8888/images/Violet.png")
    let imageFile5 = try DownloadItem(withString: "http://localhost:8888/images/Pattern.png")

    d.download(items: [imageFile, imageFile2, imageFile3, imageFile4, imageFile5])
    //*/
    
} catch {
    print("Unable to create Download item")
}

//hard stop app after 10 seconds...
RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))


