import Foundation

struct Result: Decodable {
    let boxOfficeResult: ResultList
}

struct ResultList: Decodable {
    let dailyBoxOfficeList: [List]
}

struct List: Decodable {
    let openDt: String
    let audiAcc: String
    let rank: String
    let movieNm: String
}



