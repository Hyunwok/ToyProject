import Foundation

struct Result: Codable {
    let boxOfficeResult: ResultList
}

struct ResultList: Codable {
    let dailyBoxOfficeList: [List]
}

struct List: Codable {
    let openDt: String
    let audiAcc: String
    let rank: String
    let movieNm: String
}



