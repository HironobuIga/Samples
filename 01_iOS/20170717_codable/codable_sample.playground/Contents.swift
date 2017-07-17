//: Playground - noun: a place where people can play

import UIKit

// swift4.0のCodableを使用する前のコード
struct Person {
    let name: String
    let age: Int
}

extension Person {
    class Helper: NSObject, NSCoding {
        let person: Person?
        
        init(person: Person) {
            self.person = person
            super.init()
        }
        
        required init?(coder aDecoder: NSCoder) {
            guard let name = aDecoder.decodeObject(forKey: "name") as? String,
                let age = aDecoder.decodeObject(forKey: "age") as? Int else {
                    return nil
            }
            person = Person(name: name, age: age)
            super.init()
        }
        
        func encode(with aCoder: NSCoder) {
            guard let person = person else {
                return
            }
            aCoder.encode(person.name, forKey: "name")
            aCoder.encode(person.age, forKey: "age")
        }
    }
}

let person = Person(name: "Foo", age: 10)
let helper = Person.Helper(person: person)
let data = NSKeyedArchiver.archivedData(withRootObject: helper)


// swift4.0 codable を採用した場合
struct PersonCodable: Codable {
    enum Child: String, Codable {
        case son, daughter
    }
    let name: String
    let age: Int
    let children: [Child]
}

let personCodable = PersonCodable(name: "Foo", age: 10, children: [.son, .daughter])
let jsonEncoder = JSONEncoder()
let propertyListEncoder = PropertyListEncoder()
let jsonDecoder = JSONDecoder()
let propertyListDecoder = PropertyListDecoder()
let dataJsonCoded = try! jsonEncoder.encode(personCodable)
let dataPropertyListEncoded = try! propertyListEncoder.encode(personCodable)

let jsonDecodedData = try? jsonDecoder.decode(PersonCodable.self, from: dataJsonCoded)
