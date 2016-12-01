# ❄️ Fridge ❄️
[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)

<<<<<<< HEAD

**Fridge** is simple and uber easy to use background object downloader. And it's 100% Siwft3 !!

=======
**Fridge** is simple and uber easy to use background object downloader. And it's 100% Swift3 !!
>>>>>>> e16966760d0fe0f5f848f2940ebb9313b7792509

## Basic usage example :

```Swift
//#1: declare object you want to download
var item = DownloadItem()

<<<<<<< HEAD
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
```


**STILL UNDER HEAVY DEVELOPMENT**

=======
//declare an action (closure) to perform after download
dlo.onComplete = {
    print("◉ Successfully downloaded google.com page")
}

//..and kick-off download !!
let d = Downloader(withObject: dlo)
d.download()
```

>>>>>>> e16966760d0fe0f5f848f2940ebb9313b7792509
Stay tunned for more !!

**STILL UNDER HEAVY DEVELOPMENT**
*v0.1b*
