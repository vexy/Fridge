# ❄️ Fridge ❄️ v0.1b
[![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=master)](https://travis-ci.org/vexy/Fridge)
[![codecov](https://codecov.io/gh/vexy/Fridge/branch/master/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge)


**STILL UNDER HEAVY DEVELOPMENT**

Fridge is uber easy to use background object downloader.

---

## Basic usage example :

```Swift
//declare object you want to download
let target = URL(string: "https://www.google.com")!  //experiment with different soures or real files
var dlo = DownloadableObject(withURL: target)

dlo.onComplete = {
    print("◉ Successfully downloaded google.com page")
}


//..and download it !!
let d = Downloader(withObject: dlo)
d.download()
```


Stay tunned for more !!
