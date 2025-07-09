<h1 align="center">
❄️ Fridge ❄️
</h1>

<p align="center">
  <b>Fridge</b> is <code>Swift</code> based freezing device.<br>
  It helps you <b>fetch-n-store</b> data without major hassle.<br><br>
  <i>Lightweight, Async/Await friendly, Zero dependency, <code>Foundation</code> based.</i>
  
  <div align="center", style="border: 0.15px dashed yellow; padding: 1px">
      <a href="https://github.com/vexy/Fridge/releases">
        <img alt="GitHub release (latest by date)" src="https://img.shields.io/github/v/release/vexy/Fridge?color=green&display_name=release&label=Latest%20release">
      </a>
      <img src="https://img.shields.io/github/languages/code-size/vexy/fridge?color=g">
      <a href="https://github.com/vexy/Fridge/blob/master/LICENSE">
        <img alt="License" src="https://img.shields.io/github/license/vexy/Fridge">
      </a>
  </div>
</p>

<p align="center">
  <h3>Supported platforms</h3>
  <img alt="Platforms" src="https://img.shields.io/badge/Platform-iOS%2C%20macOS%2C%20tvOS%2C%20watchOS-blue">
  <a href="https://github.com/vexy/Fridge/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/vexy/fridge">
  </a>
  <h3>Tests</h3>
  <a href=https://github.com/vexy/Fridge/actions/workflows/release_workflow.yml">
      <img alt="Release build" src="https://github.com/vexy/Fridge/actions/workflows/release_workflow.yml/badge.svg">
  </a>
  <a href="https://github.com/vexy/Fridge/actions/workflows/tests_workflow.yml">
    <img alt="Tets build" src="https://github.com/vexy/Fridge/actions/workflows/tests_workflow.yml/badge.svg">
  </a>
</p>

## 💠 Library description
`Fridge` is a freezing device ❄️ so it **has** to keep things cool enough, exposing just icy interface.

Fridge is designed to _reduce the pain with most common software operations_ such as **[fetching](#networking)** and **[storing](#persistant-local-storage)** data. Or something like this:
  - fetching _your stuff_ from the network,
  - parsing or decoding (JSON) data,
  - doing boring _error checking_
  - storing _the stuff_ somewhere on disk
  - doing boring _error checking_ again
  - invoking more than 1 dependency for this (not using `Fridge`)
  - and yeah... even cursing old **closures**.
  - (not)doing tests

Fridge is so `async/await` friendly and designed with simplicity and flexibility in hand. With Fridge, you can even _say goodbye to closures and CoreData_ if you want! 🤷🏻‍♂️

Checkout [documentation](Docs/Usage.md) for more information.

> _Talking is cheap. Show me the code._ - Linus Torvalds

## 🕸 Networking
```Swift
// define your endpoint
let endpoint = URL("https://github.com/vexy/")!

// conform your fancy struct to Decodable
struct GitHubRepoObject: Decodable {
  var name: String
  var repositoryURL: URL
  
  // ... some other fields
}

// use Fridge to grab🔮 data from the network endpoint
do {
  let myRepo: GitHubRepoObject = try await Fridge.grab🔮(from: endpoint)
  
  // do something with your object
  print(myRepo)
  print(myRepo.name)
} catch let err {
  print("Naaah.. Something bad happened: \(err)")
}
```
Checkout more [_documentation on networking_](Docs/Usage.md#network-fetching) or start with basic [code **examples**](Docs/Examples/).
  

## 💾 Persistant (local) storage

Fridge storage mechanics are built on Foundation principles and use `BSON` as internal storage mechanism. All you have to do is to conform your struct to `Encodable` and you're ready to go, Fridge will take care of the rest.  
  

```Swift
// conform your fancy struct to Decodable
struct GitHubRepoObject: Decodable {
  var name: String
  var repositoryURL: URL
}

// freeze it to local storage in just on line
do {
  try Fridge.freeze🧊(myRepo, id: "myIdentifier")
} catch let e {
  print("Whoops... Can't freeze because: \(e)")
}
```  

Checkout [documentation](Docs/Usage.md) for more information.  

# Real world use cases
Here is some **real world** usage of `Fridge`:  
  - [Clmn](https://github.com/igr/Clmn) - Beautiful macOS app that operates with tasks in columns
  - [Sample code](/Docs/Examples) - with Fridge in practical usage

## Installation instructions
Using `Swift Package Manager` is by far the sexiest way to install `Fridge`.

```Swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "YOUR-PACKAGE",
    dependencies: [
        .package(url: "https://github.com/vexy/Fridge.git", .upToNextMajor(from: "0.9"))
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

### Minimum versions required
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

Since `v1.0` Fridge **does not** use anything other than Foundation provided `JSONEncoder`.  
Up to `v0.9.2` Fridge used [BSONCoder v0.9](https://github.com/vexy/bsoncoder) as main encoding device.  

# Documentation
> _RTFM isn't a joke..._ 🥴 
    
In the **[Docs](Docs/Usage.md)** you'll quickly figure out how to:
  - *easily fetch object* from the network,
  - *persistently store* your objects,
  - *load them back* into your app,
  - *catch nasty errors* along the way
  - all other dirtly little secrets about the Fridge
  
Check [usage examples](Guides/Examples) or entire [Guides](Guides/) collection for more goodies.  
`Xcode Playground` file can be found [here](Guides/Examples/Fridge-basics.playground).
For a bigger picture overview, feel free to check [architecture](Guides/Fridge.diagram.md) diagrams... ∰      


# Contribution guidelines
If you like Fridge, feel free to fire a [pull request](https://github.com/vexy/Fridge/pulls).
The prefered way is to branch off the `main` branch, complete feature or a fix and then merge to `development`. After the pull request has been approved, your change will be merged to `main`.  

Don't be affraid to start any [discussions](https://github.com/vexy/Fridge/discussions) if you think so.  
[Issues](https://github.com/vexy/Fridge/issues) section is a good way to start, if you stumble upon the way.  

---   
(**FRIDGE IS UNDER ACTIVE DEVELOPMENT ALMOST REACHING v1.0**)  
Fridge **BETA** release : *v0.9.3 ( UTC2022-09-24 )*

Copyright © 2016 Veljko Tekelerović | MIT license  
**PGP:** `6302 D860 B74C BD34 6482 DBA2 5187 66D0 8213 DBC0`


<p align="center">
    <code>Fridge</code> - <b>Lightweight</b>, <b>fast</b> and extreeemely <b>simple to use fetch or store mechanism.</b><br>
    <a href="https://stackexchange.com/users/215166"><img src="https://stackexchange.com/users/flair/215166.png?theme=clean" width="208" height="58" alt="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites" title="profile for Vexy on Stack Exchange, a network of free, community-driven Q&amp;A sites">
    </a>
</p>
