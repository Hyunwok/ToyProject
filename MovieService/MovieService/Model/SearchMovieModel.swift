import UIKit

struct SearchMovieInfo: Codable {
    let title: String
    let link: String
    let image: String
    let pubDate: Date
    let director: String
    let actor: String
    let userRating: Int
}
