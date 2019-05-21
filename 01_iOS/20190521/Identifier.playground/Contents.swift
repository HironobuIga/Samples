import Foundation

typealias Identifiable = RawRepresentable & Codable & Equatable & Hashable

struct User: Codable {
    let id: ID
    let name: String
    let job: Job
    
    // String型からID型にパースできるようにRawRepresentableに準拠
    // Decode, EncodeできるようにCodableに準拠
    struct ID: Identifiable {
        typealias RawValue = String
        let rawValue: RawValue
    }
}

struct Job: Codable {
    let id: ID
    let name: String
    
    struct ID: Identifiable {
        typealias RawValue = String
        let rawValue: RawValue
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


let user: User
do {
    user = try JSONDecoder().decode(User.self, from: userData)
    print("User: \(user)")
    // String型として使用する場合にはrawValueを使用する
    print("UserID: \(user.id.rawValue)")
    print("UserJobID: \(user.job.id.rawValue)")
} catch let error {
    fatalError(error.localizedDescription)
}

do {
    let encodedUserData = try JSONEncoder().encode(user)
    let encodedUserString = String(data: encodedUserData, encoding: .utf8)!
    print(encodedUserString)
} catch let error {
    fatalError(error.localizedDescription)
}
