| Builds | Test coverage and code quality |
| ---- |
| [![Build Status](https://travis-ci.org/vexy/Fridge.svg?branch=swift5)](https://travis-ci.org/vexy/Fridge) | [![codecov](https://codecov.io/gh/vexy/Fridge/branch/swift5/graph/badge.svg)](https://codecov.io/gh/vexy/Fridge) |
| [![Build Status](https://app.bitrise.io/app/0a6d6b6f5e679665/status.svg?token=2lSrCvvachugWUQaYZ44Og)](https://app.bitrise.io/app/0a6d6b6f5e679665) | [![Codacy Badge](https://api.codacy.com/project/badge/Grade/24b9cd48be1d4d5487c68e0acf796f50)](https://www.codacy.com/app/veljko-tekelerovic/Fridge?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=vexy/Fridge&amp;utm_campaign=Badge_Grade) |


![package_manager](https://img.shields.io/badge/SPM-comming%20soon-orange)
[![Packagist](https://img.shields.io/packagist/l/doctrine/orm.svg)]()

# Fridge ❄️0.7.1
**Fridge** is the silliest refrigerator you'll ever use on a dialy basis.  
With Fridge, your fancy `struct`(s) will raise and shine, allowing you to focus on your plan to conquer Earth...finally !

#### Waaaait... a refrigerator 🤔 There has to be a trick !
That's right! `Fridge` is actually one super fancy computer program, and if you talk with it gently, it can do magic for you !

Say, you want to store your data into persistant storage. Easy !  
Just conform your fancy `struct` into `Codable` first:
```Swift
struct My🧞truct: Codable {
    var something: String
    var elixirOfL❤️fe: URL

    //fatalError if elixir cannot be initialized (!)
    init() { ... }  
}

let crucialObject = My🧞‍truct(private🔑: 0xb375af2.hash())
//..okay, I'm ready. Now what? 🤨
```
Then, as you would do with let's say pizza, just:

```Swift
//freeze it into refrigerator
Fridge.freeze🧊(crucialObject)
```

And you're done !

### 😮 really? What else can Fridge do
Inside `Fridge` there are handy of prepacked stuff:
  - `freeze` method to persistantly store your `struct`s to disk
  - `unfreeze` method to directly load your `struct` back from the storage
  - `grab(from:)` or `grab(using:)` method to get your `struct` directly from the network
  - then you can...

### Stop. Have you said network calls ?!!? 😲
Well yeah. Prepare your `URL` or `URLRequest` object first:
```Swift
let thisURL = URL(string: "https://my.secret.plan/api/v433x/users")
//or if you need better control over URL request then:
let customRequest = URLRequest(..someMagic...)
```
Then, call `grab(from:)` or `grab(using:)` to get it from the network like so:
```Swift
let networkObject = Fridge.grab(from: thisURL)
//or this one, depending on your needs
let anotherOne = Fridge.grab(using: customRequest)
```
*... MORE TO COME ...*
--

## Okay. How can I install Fridge
Using `Swift Package Manager` is by far the sexiest way to install silly `Fridge`.  
Just add following line to your `Package.swift`:  
`dependency: ["this_repo_i_guess_"]`

---   
(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)  
Package **BETA** release : *v0.7.1 ( UTC2020-01-29 )*

Developed under MIT license   
Copyright © 2020 Veljko Tekelerović
