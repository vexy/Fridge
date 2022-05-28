import UIKit
import Fridge

//MARK: Grab example

let todoEndpoint = URL(string: "https://jsonplaceholder.typicode.com/todos/")!
struct ToDo: Decodable {
    var id: Int
    var title: String
    var completed: Bool
}

async {
    print("--> Grabbing all TODO objects...")
    do {
        let results: [ToDo] = try await Fridge.grab🔮(from: todoEndpoint)
        // print all the results
        for item in results {
            print("ID:\(item.id) - \(item.title)")
        }
        print("|\nSuccessfully grabbed \(results.count) ToDO objects\n-----")
    } catch {
        print("Grab failed.")
    }
}

//MARK: - Push example

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

async {
    print("--> Posting new comment...")
    do {
        
        let newComment = Comment(postId: 12, id: 100, name: "New comment", email: "some@email.com", body: "Body of the new comment")
        
        let response: Comment = try await Fridge.push📡(newComment, to: "https://jsonplaceholder.typicode.com/comments/")

        print("New comment successfuly pushed.\nReturned (response) object:")
        print(response)
    } catch {
        print("Push failed")
    }
}
