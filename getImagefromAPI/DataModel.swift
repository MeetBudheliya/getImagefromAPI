//
//  DataModel.swift
//  getImagefromAPI
//
//  Created by MAC on 19/12/20.
//

import Foundation
//struct Datas:Decodable{
//    let per_page:String?
//    let data:[Data]
//    let support:Support?
//}
//struct Data:Decodable{
//    let id:String?
//    let email:String?
//    let first_name:String?
//    let avatar:String?
//}
//struct Support:Decodable {
//    let url:String?
//    let text:String?
//}
// MARK: - Welcome
struct Welcome: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [Datum]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}
