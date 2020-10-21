import Foundation

struct MovieModel: Codable {
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

    init(json: [String:Any]) {
        openDt = json["openDt"] as? String ?? ""
        audiAcc = json["audiAcc"] as? String ?? ""
        rank = json["rank"] as? String ?? ""
        movieNm = json["movieNm"] as? String ?? ""
    }
}



