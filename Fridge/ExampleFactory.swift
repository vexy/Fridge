//
//  ExampleFactory.swift
//  Fridge
//
//  Created by Veljko Tekelerovic on 29.3.17.
//
//

import Foundation

class ExamplesFactory {
    private static let sharedFridge = Fridge.shared
    static var semaphore: DispatchSemaphore?
    
    class func downloadOneItem() {
        var item = FridgeItem()
        
        item.url = URL(string: "http://www.google.com/")!
        item.downloadDestination = URL(string: "/Users/vexy/Desktop/Fridge/")
        item.onComplete = { object in
            print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
        }
        item.onFailure = { error in
            print("✋ Unable to complete download ! Following error occured \(error.localizedDescription)")
        }
        
        sharedFridge.download(item: item)
    }
    
    class func downloadTenFiles() {
        do {
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
            
            let allOfEm = [imageFile0, imageFile1, imageFile2, imageFile3, imageFile4, imageFile5, imageFile6, imageFile7, imageFile8, imageFile9]
            
            sharedFridge.download(items: allOfEm)
        }catch {
            print("😔 Unable to create Download item")
        }
    }
    
    class func downloadBigFiles() {
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
        
        do {
            let bigOnes0 = try FridgeItem(withString: "http://4k.com/wp-content/uploads/2014/06/4k-image-tiger-jumping.jpg")
            let bigOnes1 = try FridgeItem(withString: "http://cdn.wallpapersafari.com/48/32/AHtKXu.jpg")
            let bigOnes2 = try FridgeItem(withString: "http://www.hd-wallpaper1.com/images/red-macaw-4k.jpeg")
            let bigOnes3 = try FridgeItem(withString: "http://i.rtings.com/images/reviews/m-series-2015/m-series-2015-upscaling-4k-large.jpg")
            
            sharedFridge.download(items: [bigOnes0, bigOnes1, bigOnes2, bigOnes3])
        } catch {
            print("😔 Unable to create Download item")
        }
    }
    
}
