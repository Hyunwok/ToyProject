import Foundation

struct RecommendMovieResult: Decodable {
    let movieListResult: [RecommendMovieList]
}

struct RecommendMovieList: Decodable {
    let movieNm: String
    let movieNmEn: String
    let typeNm: String
    let genreAlt: String
}
