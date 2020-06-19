import UIKit

struct LogInModel: Codable {
    let id: String
    let pw: String
}

struct RegisterModel: Codable {
    let id: String
    let pw: String
    let num: String
    let name: String
}

struct FindIdModel: Codable {
    let name: String
    let email: String?
    let num: String?
}

