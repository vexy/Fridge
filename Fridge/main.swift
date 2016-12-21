//
//  main.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.11.16.
//
//

import Foundation


print("WELCOME TO ❄️FRIDGE❄️")

//santa's little helper ;)
let appTimeout : TimeInterval = TimeInterval(15) //seconds

do {
//    var item = try DownloadItem(withString: "www.google.com")
    var item = FridgeItem()
    
    item.url = URL(string: "http://www.google.com")!
    item.onComplete = { (object) in
        print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
    }
    item.onFailure = { (error) in
        print("✋ Unable to complete download ! Following error occured \(error.localizedDescription)")
    }
    
    let d = Fridge.shared
    
    //setup custom 'caches' directory
    
    // SETUP YOUR FINAL DESTINATIONS HERE !!!
    d.cacheDestination = "/Users/vexy/Desktop/Fridge/"
    
    
    d.download(item: item)
    
    
    /*
        Collection of free images that we can use to test Downloader :
     
            - http://www.bigfoto.com/airplane.jpg                               #0
            - http://www.bigfoto.com/image-park-lake.jpg                        #1
            - http://www.bigfoto.com/dog-animal.jpg                             #2
            - http://www.bigfoto.com/alps-mythen-image.jpg                      #3
            - http://www.bigfoto.com/snow-mountains.jpg                         #4
            - http://www.bigfoto.com/fruits-picture.jpg                         #5
            - http://www.bigfoto.com/sunset-photo.jpg                           #6
            - http://www.bigfoto.com/coast.jpg                                  #7
            - http://www.bigfoto.com/image-leaves.jpg                           #8
            - http://www.bigfoto.com/sites/main/aegeri-lake-switzerland.JPG     #9
     
        Copyright © BigFoto.com
    */
    
    ///*
    let imageFile0 = try FridgeItem(withString: "http://www.bigfoto.com/airplane.jpg")
    let imageFile1 = try FridgeItem(withString: "http://www.bigfoto.com/image-park-lake.jpg")
    let imageFile2 = try FridgeItem(withString: "http://www.bigfoto.com/dog-animal.jpg")
    let imageFile3 = try FridgeItem(withString: "http://www.bigfoto.com/alps-mythen-image.jpg")
    let imageFile4 = try FridgeItem(withString: "http://www.bigfoto.com/snow-mountains.jpg")
    let imageFile5 = try FridgeItem(withString: "http://www.bigfoto.com/fruits-picture.jpg")
    let imageFile6 = try FridgeItem(withString: "http://www.bigfoto.com/sunset-photo.jpg")
    let imageFile7 = try FridgeItem(withString: "http://www.bigfoto.com/coast.jpg")
    let imageFile8 = try FridgeItem(withString: "http://www.bigfoto.com/image-leaves.jpg")
    let imageFile9 = try FridgeItem(withString: "http://www.bigfoto.com/sites/main/aegeri-lake-switzerland.JPG")
    

    d.download(items: [imageFile0, imageFile1, imageFile2, imageFile3, imageFile4, imageFile5, imageFile6, imageFile7, imageFile8, imageFile9])
    //*/
    
} catch {
    print("😔 Unable to create Download item")
}

//hard stop this app timeout period
RunLoop.main.run(until: Date(timeIntervalSinceNow: appTimeout))
