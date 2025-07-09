import UIKit
import Fridge

//MARK: - Basic network Grab example

// define your URL endpoint
let todoEndpoint = URL(string: "https://jsonplaceholder.typicode.com/todos/")!

// conform your struct to Decodable
struct ToDo: Decodable {
    var id: Int
    var title: String
    var completed: Bool
}

//TODO: Use other async methods that serve your needs
async {
    print("---> Grabbing all TODO objects from URL endpoint using Fridge")
    do {
        // ** Grab with Fridge !! **
        let results: [ToDo] = try await Fridge.grab🔮(from: todoEndpoint)

        // do something with results....
        for item in results {
            print("ID:\t\(item.id)")
            print("Title:\t\(item.title)")
        }
    } catch let fridgeError {
        // handle any errors that we received
        print("Grab failed. Error: \(fridgeError)")
    }
}
