
# 👨‍🚀 Fridge Usage Guide
Following guide describes **how to**:
  - [fetch data from network](#network-fetching)
  - [load/store an object](#data-handling)
  - [handle errors](#error-handling)
  
Checkout _architecture overview_ in separate [diagram](Guides/Fridge.diagram.md) file.
Find out different wasy to easily use`Fridge` in provided [playground file](Guides/Examples/Fridge-basics).  
For deeper information, you can check `in-code` documentation.  

---  

## Network fetching
|Method|Description|
|-|-|
`Fridge.grab🔮(from: URL)`|Grabs your model from the network endpoint (_iOS 15+ only_)|
|`Fridge.push📡(object, to)`|Pushes (sends) your model to designated network endpoint (_iOS 15+ only_)|

With Fridge, network fetching is performed in just 3 steps:
1. Conform your desired `struct` to `Decodable`
2. Define `URL` endpoint where your model resides
2. Await for Fridge to `grab🔮(...)` the object

Example code: 
```Swift
// Step 1 - conforming to Decodable
struct MyStuff: Decodable {
    var something: String
    var elixirOfL❤️fe: URL
    var piTimesE: Float

    init(private🔑: muhash(0x61F612d)) {
        //do fatalError if elixir cannot be initialized (!)
    } 
}


// Step 2 - defining fancy URL endpoint
let fancy_URL = URL(string: "https://fancy.url.stuff")!  //be nice and unpack this before serious usage


// Step 3 - Grab it with Fridge !
let _stuff: MyStuff = try await Fridge.grab🔮(from: that_fancyURL)
print("Elixir of live is: \(_stuff.elixirOfL❤️fe)")

```

Yup, and you're all **set**. `Fridge` will perform the network fetch, decode network data and return your `struct` as you wished. Easy peasy right ?

**IMPORTANT:**  
Fridge may encounter several types of errors along the way. Make sure to check error handling section for more details.  

## Data handling
Similar to fetching, data storing and retreiving is done in few simple steps:
1. Define desired `struct` and conform it to `Encodable`
2. Define unique `identifier` to mark your struct
3. Use Fridge to either `freeze🧊(...)` or `unfreeze` the object
  
### 🧊 Freezing an object
```Swift
// Step 1 - Conforming to Encodable
struct StoringStuff: Encodable {
    var _id: UUID
    enum Stages {
        case Opened
        case Closed
    }
}
let storeObject = StoringStuff()

// Step 2 - Define unique identifier
let storeIdentifier = "store.identifier"


// Step 3 - Freeze it with Fridge !
try Fridge.freeze🧊(storeObject, storeIdentifier)
```

### Unfreezing an object
If your object is already frozen before, you can revert it back easily, in just few steps:
1. prepare your `struct` by conforming to `Decodable`
2. define unique `identifier`
3. Use Fridge to `unfreeze` the object
```Swift
// Step 1 - Preparing struct with Decodable
struct StoringStuff: Decodable {
    let category: String
    let isRealExample: Bool
}

// Step 2 - Define unique identifier
let objectID = "object.xyz"

// Step 3 - Unfreeze it with Fridge (assuming it was frozen before)
let retrievedObject = try Fridge.unfreeze(objectID)
```

**IMPORTANT:**  
If your store identifier cannot be found `Fridge` will throw an Error. Check the section below for more information on error handling.

## ⛔️ Error Handling
Each of the Fridge method, is internally marked with `throws` keyword. Here's what you can deal with:

```Swift
enum FridgeErrors: Error {
    case grabFailed
    case pushFailed
    case decodingFailed
}
```

You can expect `FridgeErrors` on following calls:
  - `grab🔮`

_NOTE:_
Fridge error model is not yet final. You may expect different error message or structures before `v1.0` release.
