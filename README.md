# ❄️ Fridge ❄️ v0.55
[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)

**Fridge** is simple and uber easy to use background object downloader. And it's 100% Siwft3 !!


## Basic usage example :

```Swift
//#1: declare object you want to download
var item = DownloadItem()

item.itemURL = URL(string: "http://www.google.com")!

//#2: declare action (closures) that will be performed after download  (psst.. things will work just fine even if you don't do this !! 😜)
item.onComplete = { (object) in
    print("💪 Download complete ! File is permanently stored at : \(object.absoluteString)")
}
item.onFailure = { (error) in
    print("👎 Unable to complete download ! Following error occured \(error.localizedDescription)")
}

//#3: kick-off your download !!
let d = Downloader.shared
d.download(item: item)

//small bonus as of v0.55 :
d.cacheDestination = "/some/folder/that/iwant/"
```


## Main features :
- Easy declaration of file/image/object to be downloaded
- Asynchronous object download on background threads
- Assign 'completion' and 'failure' closures to perform your custom work after download
  --  or you can just ignore this and access your object directly after it has been downloaded
- Customizable destination for downloading objects
  -- you can always use default system provided Caches folder

Stay tunned for more !!


---
If you experience some problems, feel free to fire an issue on 'Issues' page


Feel free to contribute at *any time* !!

(**STILL UNDER HEAVY DEVELOPMENT**)
