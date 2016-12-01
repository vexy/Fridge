# ❄️ Fridge ❄️
[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)

**Fridge** is simple and uber easy to use background object downloader. And it's 100% Swift3 !!

## Basic usage example :

```Swift
//declare object you want to download
let target = URL(string: "https://www.google.com")!  //experiment with different soures or real files
var dlo = DownloadableObject(withURL: target)

//declare an action (closure) to perform after download
dlo.onComplete = {
    print("◉ Successfully downloaded google.com page")
}

//..and kick-off download !!
let d = Downloader(withObject: dlo)
d.download()
```

Stay tunned for more !!

**STILL UNDER HEAVY DEVELOPMENT**
*v0.1b*
