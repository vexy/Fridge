<h1 align="center">
❄️ Fridge ❄️
</h1>

<p align="center">
  <b>Fridge</b> - extremely simple <code>async/await</code> fetch-and-store implementation you'll ever see !<br>
  Let your fancy <code>struct</code>(s) raise and shine again, allowing you to focus on 💬 🥊🤖⭐️🗝 <i>stuff</i>.<br><br>
</p>
<br><br>

<table style="width:100%">
  <!-- <tr>
    <th># HEADERS HIDDEN #</th>
  </tr> -->
  <tr style="outline: thin; vertical-align: middle">
    <td>
        <a href=https://github.com/vexy/Fridge/actions/workflows/release_workflow.yml">
            <img alt="Release build" src="https://github.com/vexy/Fridge/actions/workflows/release_workflow.yml/badge.svg">
        </a>
    </td>
    <td>
        <a href="https://github.com/vexy/Fridge/releases">
            <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/vexy/Fridge?color=green&display_name=release&label=Latest%20release">
        </a>
    </td>
    <td><a href="https://github.com/vexy/Fridge/search?l=swift"><img alt="Github top language" src="https://img.shields.io/github/languages/top/vexy/Fridge"></a></td>
    <td><img alt="Platforms" src="https://img.shields.io/badge/Platform-iOS%2C%20macOS%2C%20tvOS%2C%20watchOS-blue"></td>
    <td><a href="https://github.com/vexy/Fridge/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/vexy/Fridge"></a></td>
  </tr>
</table>
</p>

---

<br>
<p align="center">
  <a href="https://github.com/vexy/Fridge/actions/workflows/tests_workflow.yml">
    <img alt="Tets build" src="https://github.com/vexy/Fridge/actions/workflows/tests_workflow.yml/badge.svg">
  </a>
  <a href="https://github.com/vexy/Fridge/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/vexy/fridge">
  </a>
  <img src="https://img.shields.io/github/languages/code-size/vexy/fridge?color=g">
</p>

# 💠 Library interface
`Fridge` is a freezing device ❄️. It has to keep things cool enough, exposing following icy interface.

### Async/Await networking
  - `Fridge.grab🔮(from: URL)` -> Grabs your model from the network endpoint (_iOS 15+ only_)
  - `Fridge.push📡(object, to)` -> Pushes (sends) your model to designated network endpoint (_iOS 15+ only_)
  
Fridge is supported by `async/await` and is here to reduce the pain of:
  - fetching _your stuff_ from the network,
  - parsing or decoding (JSON) data,
  - doing boring _error checking_
  - and yeah... good old **closures**.

With Fridge, you can even _say goodbye to closures and CoreData_ if you want!    

### Persistant storage
  - `Fridge.freeze🧊(object, identifier)` -> Safely "freezes" your `struct` to persistant store
  - `Fridge.unfreeze🪅🎉(identifier)` -> "Unfreezes" (previously frozen), `struct` giving you control of it
  -  `Fridge.isFrozen🔬(identifier)` -> Quickly check if your `Fridge` have been loaded with certain `struct`

Fridge storage mechanics are built on Foundation principles and use `BSON` as internal storage mechanism. All you have to do is to conform your struct to `Encodable` and you're ready to go, Fridge will take care of the rest.  
Checkout internal documentation for more information.  

# Code examples
> _Talking is cheap. Show me the code._ - Linus Torvalds

```Swift
// Make your fancy struct conform to Decodable
struct GHRepo: Decodable {
    var name: String
    var repositoryURL: URL
}

// Call grab🔮 method...
let myRepo: GHRepo = try await Fridge.grab🔮(from: URL("https://github.com/vexy/")!)

// Then, at your will
print(myRepo)
print(myRepo.name)
```

# Documentation
> _RTFM isn't a joke..._ 🥴 
    
In the **[Docs](Guides/Usage.md)** you'll quickly figure out how to:
  - *easily fetch object* from the network,
  - *persistently store* your objects,
  - *load them back* into your app,
  - *catch nasty errors* along the way
  - all other dirtly little secrets about the Fridge
  
Check [usage examples](Guides/Examples) or entire [Guides](Guides/) collection for more goodies.  
`Xcode Playground` file can be found [here](Guides/Examples/Fridge-basics).
For a bigger picture overview, feel free to check [architecture](Guides/Fridge.diagram.md) diagrams... ∰      

# Installation
Using `Swift Package Manager` is by far the sexiest way to install `Fridge`.  
Update both `dependencies` and `targets` section in your `Package.swift`, to look something like this:  

```Swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YOUR-PACKAGE",
    dependencies: [
        .package(url: "https://github.com/vexy/Fridge.git", .upToNextMajor(from: "0.8.7"))
    ],
    targets: [
        .target(name: "YOUR-TARGET", dependencies: ["Fridge"])
    ]
)
```
  
Quick links:
```
name: "Fridge"
url: "https://github.com/vexy/Fridge.git"
branch: "main"
```

## Minimum versions required
For `Fridge` to work in full capacity, following Swift & iOS configuration is _recommended_:
  - Xcode `13.1+`
  - Swift `5.5`
  - iOS `15.0+`
  - macOS `12.0`
  
Recommended versions mentioned above area guaranteed to successfully build & test `Fridge` ✅.  
If nothing else, you can always fire an [issue](https://github.com/vexy/Fridge/issues) if you stumble upon the way.
  
Although, you can even run `Fridge` with following: 😮 
  - iOS `11.0+`
  - macOS `10.14`
  
...but **you won't** be able to `grab🔮` things nor any of the fancy `async/await` things. Sorry 🤷🏻‍♂️

*NOTEs*  
Be sure to meet minimum configuration parameters as you may encounter difficult-to-recover build errors on earlier configurations.  
_Sometimes_, setting liker flag to `-Xfrontend -enable-experimental-concurrency` helps, but may fail if building with commandline.  
That may be helpfull for `Xcode 12.x`, assuming `Swift 5.x` is installed.  

Checkout official [Swift.org](https://www.swift.org/) website, for supporting earlier than minimums and other info.

## External dependencies
Fridge uses [BSONCoder v0.9](https://github.com/vexy/bsoncoder) - Copyright by [Vexy](https://github.com/vexy).  
Check original library licencing information under licencing section in README file.

# Contribution guidelines
If you like Fridge, feel free to fire a [pull request](https://github.com/vexy/Fridge/pulls).
The prefered way is to branch off the `main` branch, complete feature or a fix and then merge to `development`. After the pull request has been approved, your change will be merged to `main`.  

Don't be affraid to start any [discussions](https://github.com/vexy/Fridge/discussions) if you think so.  
[Issues](https://github.com/vexy/Fridge/issues) section is a good way to start, if you stumble upon the way.  

---   
(**FRIDGE IS UNDER ACTIVE DEVELOPMENT ALMOST REACHING v1.0**)  
Fridge **BETA** release : *v0.9 ( UTC2022-05-28 )*

Copyright © 2016 Veljko Tekelerović | MIT license  
**PGP:** `6302 D860 B74C BD34 6482 DBA2 5187 66D0 8213 DBC0`


<p align="center">
    <code>Fridge</code> - <b>Lightweight</b>, <b>fast</b> and extreeemely <b>simple to use fetch or store mechanism.</b><br>
    <a href="https://stackexchange.com/users/215166"><img src="https://stackexchange.com/users/flair/215166.png?theme=clean" width="208" height="58" alt="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites" title="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites">
    </a>
</p>
