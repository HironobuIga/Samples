import UIKit

struct User: Codable {
    let id: ID
    let name: String
    let job: Job
    
    struct ID: RawRepresentable, Codable {
        let rawValue: String
    }
}

struct Job: Codable {
    let id: ID
    let name: String
    
    struct ID: RawRepresentable, Codable {
        let rawValue: String
    }
}

let userString = """
{
    "id": "11111",
    "name": "Tanaka",
    "job": {
        "id": "01",
        "name": "engineer"
    },
}
"""

let userData = userString.data(using: .utf8)!
do {
    let user = try JSONDecoder().decode(User.self, from: userData)
    print(user)
} catch let error {
    print("\(error.localizedDescription).")
}
