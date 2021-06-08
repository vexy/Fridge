
# Fridge ❄️0.8
**Fridge** is the perhaps the silliest refrigerator implementation you'll ever see.  
With Fridge, your fancy `struct`(s) will raise and shine, allowing you to focus on your plan to conquer the Earth...finally !

Build: [![Swift](https://github.com/vexy/Fridge/actions/workflows/swift.yml/badge.svg?branch=development&event=push)](https://github.com/vexy/Fridge/actions/workflows/swift.yml)

```
print("Say whaat ?! 🤔 There has to be a trick !")
```

## So, here's the story
`Fridge` is actually one super fancy computer program, and if you talk with it gently, it can do magic for you !

Say, you *just wanna grab that model from the API* and do your stuff. **Your** stuff...  

Well, if you conform your fancy `struct` into `Decodable` first, something like this:
```Swift
struct My🧞truct: Decodable {
    var something: String
    var elixirOfL❤️fe: URL
    var piTimesE: Float

    //fatalError if elixir cannot be initialized (!)
    init(private🔑: Chachapoly20) { ... }
}
```

Then, you can go ahead and *just grab* it from that fancy `URL` of yours..

```Swift
// just grab it ?? Really... like this ??
let grabbedObject: My🧞‍truct = try await Fridge.grab🔮(from: fancyURL_of_mine)
```

Yup, and you're all set. Easy peasy right ?

## For real ?? 😮
`Fridge` is here to reduce the pain of fetching your stuff from the network, parsing, doing endless error checking and yeah... good old closures. You can even say goodbay to closures if you want.
It's build using `async/await` phylosophy and requires `Swift 5.5` to run. See common pitfalls for more details.

### Details
Inside `Fridge` there are handy of prepacked stuff:
  - `freeze` method to persistantly store your `struct`s to disk
  - `unfreeze` method to directly load your `struct` back from the storage
  - `grab(from:)` or `grab(using:)` method to get your `struct` directly from the network
  - then you can...

## Okay. How can I install Fridge ?
Using `Swift Package Manager` is by far the sexiest way to install silly `Fridge`.  
Just add following line to your `Package.swift`:
```
`dependency: ["just_copy_URL_of_this_repo"]`
```
---   
(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)  
Package **BETA** release : *v0.8.1 ( UTC2021-06-08 )*
   
Copyright © 2020 Veljko Tekelerović, MIT license
