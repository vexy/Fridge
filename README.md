
# Fridge ❄️0.8
**Fridge** is the perhaps the silliest `Swift5 async/await` network implementation you'll ever see.  
With Fridge, your fancy `struct`(s) will raise and shine, allowing you to focus on your plan to conquer the Earth...finally !

|Branch|Build status|
|-|-|
|master|[![Swift](https://github.com/vexy/Fridge/actions/workflows/swift.yml/badge.svg)](https://github.com/vexy/Fridge/actions/workflows/swift.yml)|

## Usage
So say you *just wanna grab that model from the API* and do your stuff. **Your** stuff...  

Well, if you conform your fancy `struct` into `Decodable` first:
```Swift
struct MyStuff: Decodable {
    var something: String
    var elixirOfL❤️fe: URL
    var piTimesE: Float

    init(private🔑: Chachapoly20) { ... } //do fatalError if elixir cannot be initialized (!)
}
```

Then, you can go ahead and *just grab* it from that fancy `URL` of yours..

```Swift
let _stuff: MyStuff = try await Fridge.grab🔮(from: fancyURL_of_mine)
print("Elixir of live is: \(_stuff.elixirOfL❤️fe)")
```

Yup, and you're all **set**. `Fridge` will perform the network fetch and decode the network data and return your `struct`.  
Easy peasy right ?

### Minimum iOS versions
Fridge requires following configuration:
  - Swift 5.0
  - iOS 15.0
  
`Fridge` is here to reduce the pain of fetching your stuff from the network, parsing, doing endless error checking and yeah... good old closures. You can even say goodbay to closures if you want.
It's build using `async/await` philosophy and requires `Swift 5.5` to run.

*NOTE*  
As of 6-8-2021 Fridge requires `Swift5.5` and prebuilt Swift [snapshots](https://swift.org/download/#snapshots). You may also need to set `-Xfrontend -enable-experimental-concurrency` flag in other linker flags section. Checkout official [Swift.org](https://swift.org/) website for more info.

### Library reference
`Fridge` has very simple interface to work with:
  - `Fridge.grab🔮(from: URL)` method to get your `struct` directly from the network
  - `Fridge.freeze🧊()` to store your `struct` on the disk

## How can I install Fridge ?
Using `Swift Package Manager` is by far the sexiest way to install silly `Fridge`.  
Just add following line to your `Package.swift`:
```
Package: "Fridge",  
URL: https://github.com/vexy/Fridge.git
```
---   
(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)  
Package **BETA** release : *v0.8.4 ( UTC2021-12-07 )*

Copyright © 2020 Veljko Tekelerović, MIT license
