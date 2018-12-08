import Foundation

let jsonData = """
{
    "first_name": "Taro",
    "family_name": "Tanaka"
}
""".data(using: .utf8)!

struct User: Decodable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        
//        case lastName = "family_name" // A こちらの定義ではパースに失敗
        case lastName = "familyName" // B こちらの定義ではパースに成功
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
do {
    let user = try decoder.decode(User.self, from: jsonData)
    print("first name: \(user.firstName), last name: \(user.lastName)")
} catch let error {
    print(error)
}
