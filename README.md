<h1 align="center">
❄️ Fridge ❄️
</h1>

<p align="center">
  <b>Fridge</b> - perhaps the silliest <code>Swift5 async/await</code> fetch-and-store implementation you'll ever see !<br>
  Let your fancy <code>struct</code>(s) raise and shine again, allowing you to focus on 💬 🥊🤖⭐️🗝 <i>stuff</i>.<br><br>
  <code>Fridge</code> - <b>Lightweight</b>, <b>fast</b> and extreeemely <b>simple to use !</b>
</p>

<p align="center">
    <a href="https://stackexchange.com/users/215166"><img src="https://stackexchange.com/users/flair/215166.png?theme=clean" width="208" height="58" alt="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites" title="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites">
    </a>
</p>
<br>
<table style="width:100%">
  <!-- <tr>
    <th># HEADERS HIDDEN #</th>
  </tr> -->
  <tr style="outline: thin">
    <td><img alt="" src="https://github.com/vexy/Fridge/actions/workflows/swift.yml/badge.svg"></td>
    <td><img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/vexy/Fridge?color=green&display_name=release&label=Latest%20release"></td>
    <td><img alt="Github top language" src="https://img.shields.io/github/languages/top/vexy/Fridge"></td>
    <td><img alt="Platforms" src="https://img.shields.io/badge/Platform-iOS%2C%20macOS%2C%20tvOS%2C%20watchOS-blue"></td>
    <td><img alt="GitHub" src="https://img.shields.io/github/license/vexy/Fridge"></td>
  </tr>
</table>
</p>

---

<br>
<p align="center">
  <img src="https://github.com/vexy/Fridge/actions/workflows/fridge_workflow.yml/badge.svg">
  <img src="https://img.shields.io/github/issues/vexy/fridge">
  <img src="https://img.shields.io/github/languages/code-size/vexy/fridge?color=g">
</p>
<br><br>

<!-- [![Tests](https://github.com/vexy/Fridge/actions/workflows/fridge_workflow.yml/badge.svg)](https://github.com/vexy/Fridge/actions/workflows/fridge_workflow.yml)  
![GitHub issues](https://img.shields.io/github/issues/vexy/fridge)  
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/vexy/fridge?color=g) -->


# 💠 Library interface
`Fridge` is a freezing device. It has to keep things cool enough, exposing this icy interface for us:
  - `Fridge.grab🔮(from: URL)` - Allows you to easily "grab" your model from the network endpoint
  - `Fridge.freeze🧊(object, identifier)` - to (persistently) "freeze" your `struct` for future use
  - `Fridge.unfreeze(identifier)` - to load your `struct` back and take control of it
  
`Fridge` is built using `async/await` philosophy and is here to reduce the pain of _fetching your stuff from the network_, parsing, _storing and retreiving stuff_, doing endless _error checking_ and yeah... good old **closures**. You can even say goodbay to closures and CoreData if you want!  
`Fridge` is built on Foundation principles and uses _BSON_ as internal storage mechanism. 
It is **lightweight**, with extremely narrow interface, with small - Foundation based - `Error` type system.

### _"Talking is cheap. Show me the code. - Linus Torvalds"_

```Swift
// there's a catch here !
struct GHRepo {
    var name: String
    var repositoryURL: URL
}

let someRepo: GHRepo = try await Fridge.grab🔮(from: URL("https://github.com/vexy/")!)
print(someRepo)

// ..and that's it ! (khm)
```  

### _"RTFM isn't a joke. So..."_ 
Oh yeah, `Fridge` can ofer way way more, _but it's alllll in the [Docs](Guides/Usage.md)_ 🥴   
Aside from discovering how to remove that _shocking build error_ from the 👆 code example,in the **Docs** you'll quickly figure out how to:
  - *persistently store* your objects,
  - *load them back* into your app,
  - *catch nasty errors* along the way
  -  (**COMMING SOON**) _fine grain_ fetch or store process
  - dirtly little secrets about the Fridge

# How to install ?
Using `Swift Package Manager` is by far the sexiest way to install silly `Fridge`.  
Update both `dependencies` and `targets` section in your `Package.swift`, something like this.
```Swift
// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "YOUR-PACKAGE",
    dependencies: [
        .package(url: "https://github.com/vexy/Fridge.git", .upToNextMajor(from: "0.8.2"))
    ],
    targets: [
        .target(name: "YOUR-TARGET", dependencies: ["Fridge"])
    ]
)
```

# Minimum versions required
`Fridge` requires following Swift & iOS configuration:
  - Swift `5.5`
  - iOS `15.0`
  - macOS `12.0`

*NOTE*  
Be sure to meet minimum configuration parameters as you may encounter difficult-to-recover build errors on earlier configurations.   
_Sometimes_, altering liker flag `-Xfrontend -enable-experimental-concurrency` helps, but may fail if building with commandline  
Checkout official Swift.org website, for supporting earlier than minimums and other info.

# External dependencies
Fridge uses [BSON](https://github.com/mongodb/swift-bson) external library, licenced under MIT Licence.  
Check original README for more instructions.

---   
(**FRIDGE IS STILL UNDER HEAVY DEVELOPMENT**)  
Fridge **BETA** release : *v0.8.6 ( UTC2022-02-23 )*

Copyright © 2016 Veljko Tekelerović | MIT license  
**PGP:** `6302 D860 B74C BD34 6482 DBA2 5187 66D0 8213 DBC0`
