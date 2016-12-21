# ❄️ Fridge ❄️ v0.6
**Fridge** is simple and uber easy to use background object downloader. And it's 100% Siwft3 !!

[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)

---

## Main features :
- Easy declaration of file/image/object to be downloaded
- Asynchronous object download on background threads
- Assign 'completion' and 'failure' closures to perform your custom work after download
  - or you can just ignore this and access your object directly after it has been downloaded
- Customizable destination for downloading objects
  - you can always use default system provided `Cache` folder

Stay tunned for more !!   

---

## Instalation guide
There is no need to clone entire repo. Entire Fridge logic is packed into 3 files you need to use.
Navigate to `Fridge` folder, select and add following files to your project :
- `Fridge.swift`
- `FridgeItem.swift`
- `FridgeErrors.swift`

(*hold short untill Cocoapods || Carthage becomes available*)

---

## Basic usage example :

```Swift
//#1: declare object you want to download
var item = FridgeItem()

item.itemURL = URL(string: "http://www.google.com")!

//#2: declare action (closures) that will be performed after download  (psst.. things will work just fine even if you don't do this !! 😜)
item.onComplete = { (object) in
    print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
}
item.onFailure = { (error) in
    print("👎 Unable to complete download ! Following error occured \(error.localizedDescription)")
}

//#3: kick-off your download !!
let myFridge = Fridge.shared

//Optionally set you download destination path (small bonus as of v0.55)
myFridge.cacheDestination = "/some/folder/that/iwant/"

myFridge.download(item: item)
```

---

If you experience some problems, feel free to fire an [issue](https://github.com/vexy/Fridge/issues).  
Feel free to contribute at *any time* by forking the repo or just ⭐️ the repo to support !



Developed under MIT license   
Copyright © 2016 Veljko Tekelerović

(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)
