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
let appTimeout : TimeInterval = TimeInterval(30) //seconds

do {
//    var item = try DownloadItem(withString: "www.google.com")
    var item = FridgeItem()
    
    item.url = URL(string: "http://www.google.com/")!
    item.onComplete = { object in
        print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
    }
    item.onFailure = { error in
        print("✋ Unable to complete download ! Following error occured \(error.localizedDescription)")
    }
    
    let d = Fridge.shared
    
    //setup custom 'caches' directory
    
    // SETUP YOUR FINAL DESTINATIONS HERE !!!
    d.cacheDestination = "/Users/vexy/Desktop/Fridge/"
    
    
    //d.download(item: item)
    
    
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
     
        And some 4k example images :
     
            - http://4k.com/wp-content/uploads/2014/06/4k-image-tiger-jumping.jpg
            - http://cdn.wallpapersafari.com/48/32/AHtKXu.jpg
            - http://www.hd-wallpaper1.com/images/red-macaw-4k.jpeg
            - http://i.rtings.com/images/reviews/m-series-2015/m-series-2015-upscaling-4k-large.jpg
    */
    let bigOnes0 = try FridgeItem(withString: "http://4k.com/wp-content/uploads/2014/06/4k-image-tiger-jumping.jpg")
    let bigOnes1 = try FridgeItem(withString: "http://cdn.wallpapersafari.com/48/32/AHtKXu.jpg")
    let bigOnes2 = try FridgeItem(withString: "http://www.hd-wallpaper1.com/images/red-macaw-4k.jpeg")
    var bigOnes3 = try FridgeItem(withString: "http://i.rtings.com/images/reviews/m-series-2015/m-series-2015-upscaling-4k-large.jpg")
    
    bigOnes3.onComplete = { object in
        do {
            let dataObject : Data = try Data(contentsOf: object)
            
            print("🐋 The big one just finished, our size is : \(dataObject.count) bytes")
        } catch {
            print("🐋😔 Unable to create Data object from this item")
        }
    }
    
    
    ///*
    let imageFile0 = try FridgeItem(withString: "http://www.bigfoto.com/airplane.jpg")
    let imageFile1 = try FridgeItem(withString: "http://www.bigfoto.com/image-park-lake.jpg")
    var imageFile2 = try FridgeItem(withString: "http://www.bigfoto.com/dog-animal.jpg")
    let imageFile3 = try FridgeItem(withString: "http://www.bigfoto.com/alps-mythen-image.jpg")
    let imageFile4 = try FridgeItem(withString: "http://www.bigfoto.com/snow-mountains.jpg")
    let imageFile5 = try FridgeItem(withString: "http://www.bigfoto.com/fruits-picture.jpg")
    let imageFile6 = try FridgeItem(withString: "http://www.bigfoto.com/sunset-photo.jpg")
    let imageFile7 = try FridgeItem(withString: "http://www.bigfoto.com/coast.jpg")
    let imageFile8 = try FridgeItem(withString: "http://www.bigfoto.com/image-leaves.jpg")
    var imageFile9 = try FridgeItem(withString: "http://www.bigfoto.com/sites/main/aegeri-lake-switzerland.JPG")
    
    imageFile9.onComplete = { object in
        print("~ This is dispatched on main thread ~")
        
        //try to manipulate this object in terms of creating an Image object
        
        do {
            let dataObject : Data = try Data(contentsOf: object)
            
            print("💪 After creating Data object, the size is : \(dataObject.count) bytes")
        } catch {
            print("😔 Unable to create Data object from this item")
        }
    }
    

    //d.download(items: [item, imageFile0, imageFile1, imageFile2, imageFile3, imageFile4, imageFile5, imageFile6, imageFile7, imageFile8, imageFile9])
    //*/
    
    imageFile2.onComplete = { object in
        print("💪 This item (\(imageFile2.url.absoluteString)) was downloaded to \(object.absoluteString)")
    }
    
    //d.download(items: [imageFile0, item, imageFile4, imageFile2, imageFile7, imageFile9])
    
    d.download(items: [item, imageFile0, imageFile1, imageFile2, imageFile3, imageFile4, imageFile5, imageFile6, imageFile7, imageFile8, imageFile9])
    
    
    print("🐋 ... 💪 now while this is downloading, we're kicking off BIG ONES !! ")
    d.download(items: [bigOnes0, bigOnes1, bigOnes2, bigOnes3])
    
} catch {
    print("😔 Unable to create Download item")
}

//hard stop this app timeout period
RunLoop.main.run(until: Date(timeIntervalSinceNow: appTimeout))
