import UIKit
import Fridge

//MARK: - Simple network Push example

// define your URL endpoint
let networkEndpoint = URL(string: "https://jsonplaceholder.typicode.com/comments/")!

// Conform your struct to Codable
struct Comment: Codable, CustomDebugStringConvertible {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    var debugDescription: String {
        return "[Comment] (ID:\(id)) \(name) - \(email). Body: \(body)"
    }
}

//TODO: Use other async methods that serve your needs
async {
    print("---> Pushing custom struct to URL endpoint using Fridge...")
    do {
        let newComment = Comment(
            postId: 12,
            id: 100,
            name: "New comment",
            email: "some@email.com",
            body: "Body of the new comment"
        )
        
        // ** Push data using Fridge !! **
        let response: Comment = try await Fridge.push📡(newComment, to: networkEndpoint)

        // handle response...
        print("New comment successfuly pushed")
        print("Returned response: ", response)
    } catch let fridgeError {
        // handle any errors that we received
        print("Grab failed. Error: \(fridgeError)")
    }
}