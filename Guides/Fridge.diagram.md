# Fridge architecture
Diagram below can be used to depict the structural layout of the Fridge library.  

```mermaid
graph TD
A[Fridge] --> B
B{Struct}
B --> E(Encodable)
B --> D(Decodable)
E --> |identifier|freeze
D --> |URL|F[grab]
D --> |identifier|G[unfreeze]
```

## Network interface perspective
You can observer `Fridge` interface from the point of network in following way:  

```mermaid
graph TD
N[Network] ==> 1(Fridge)
1 --> |url|grab
```

By providing `url` or `urlRequest` objects (and conforming your struct to `Encodable`) you can `grab` network objects easily.

Keywords:  
**`url`**, **`grab`**

## Storage interface perspective
```mermaid
graph TD
S[Storage] ==> F
F{Fridge}
F --> |identifier|U(unfreeze)
F --> |identifier|R(freeze)
B[BSON]
U --> B
R --> B
```

Keywords:  
**`identifier`**, **`freeze`**, **`unfreeze`**

---  
Copyright (c) by Vexy 2022  
Effective since: `2022-03-13`
