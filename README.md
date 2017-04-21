# ❄️ Fridge ❄️ v0.7.223
**Fridge** is simple and uber easy to use background object downloader written entirely in Swift

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/24b9cd48be1d4d5487c68e0acf796f50)](https://www.codacy.com/app/veljko-tekelerovic/Fridge?utm_source=github.com&utm_medium=referral&utm_content=vexy/Fridge&utm_campaign=badger)
[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/24b9cd48be1d4d5487c68e0acf796f50)](https://www.codacy.com/app/veljko-tekelerovic/Fridge?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=vexy/Fridge&amp;utm_campaign=Badge_Grade)   

![package_manager](https://img.shields.io/badge/SwitfPackageManager-comming%20soon-red.svg)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)]()      

## Features
- Easy declaration of file/image/object to be downloaded
- Painless asynchronous object download on background threads
- Assign `onComplete` and `onFailure` closures to perform your custom work after download
  - or you can just ignore this and access your object directly after it has been downloaded 👍
- Customizable destination of download objects
  - you can always use default system provided `Cache` folder


## Instalation guide
### Manual install

*TLDR* ; drop all `Fridge` source files in your project and you're good to go !!

There is no need to clone entire repo. Entire Fridge logic is packed into 4 files you need to use.
Navigate to `Fridge` folder, select and add following files to your project :
- `Fridge.swift`
- `FridgeItem.swift`
- `FridgeErrors.swift`
- `ItemFileManager.swift`

There's additional `main.swift` file that has primarily been used for testing. Will be removed soon, so **don't rely** on that.   
Alast, you can see the basic usage examples there as well 🙃

Having installation [issues](https://github.com/vexy/Fridge/issues) ?   Just let me know !
   
### SPM || Cocoapods || Carthage
*hold short, comming very soon !*

---

## Usage examples

### #1 General usage
```Swift
//#1: declare FridgeItem
var item = FridgeItem()
item.url = URL(string: "http://www.google.com")!

//#2: declare action (closures) that will be performed after download  (psst.. things will work just fine even if you don't do this !! 😜)
item.onComplete = { object in
    print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
}
item.onFailure = { error in
    print("👎 Unable to complete download ! Following error occured \(error.localizedDescription)")
}

// optionally set you download object destination path
item.downloadDestination = URL(string: "/some/folder/that/iwant/")!

//#3: create your Fridge
let myFridge = Fridge.shared

//...and kick-off your download !!
myFridge.download(item: item)
```

### #2 Fetch an image from internet
```Swift
//#1: declare FridgeItem that holds an image you want to download 
var someImage = FridgeItem("http://www.bigfoto.com/airplane.jpg")

//#2: access your image after it has been downloaded
item.onComplete = { imageURL in
    print("💪 Download complete ! My image file is now stored at : \(imageURL.absoluteString)")

    //create UIImage :
    let actualImage : UIImage = UIImage(contentsOfFile: imageURL.absoluteString)!

    //..then do something with this image, eg :
    let anImageView : UIImageView = UIImageView(actualImage!)
}
item.onFailure = { error in
    print("👎 Unable to download this image ! Following error occured \(error.localizedDescription)")
}

//#3: download your image with Fridge
Fridge.shared.download(item: someImage)
```

### #3 Get your entire API request (`GET`) 😱   
*-comming very very soon-*

---

If you experience some problems just fire an [issue](https://github.com/vexy/Fridge/issues).   
Feel free to contribute at *any time* by :
  - forking the repo
  - click ⭐️ to support   
   
   

THANK YOU FOR READING THIS FAR

---   
(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)  
Latest stable release : *v0.7 ( UTC2017-01-11 )*

Developed under MIT license   
Copyright © 2016 Veljko Tekelerović
