//
//  File.swift
//  
//
//  Created by Hendy Nurfrianto on 25/01/24.
//

import Foundation


public struct CategoriesGamesResponses: Decodable {

  let results: [CategoryGamesResponses]

}


public struct AddFavortResponses: Decodable {

  let results: [AddsFavortResponses]

}

public struct CategoryGamesResponses: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let originalLanguage: String?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let vote_average: Double?
    let vote_count: Int?
}

public struct AddsFavortResponses: Decodable {
    let success: Bool?
    let status_message: String?
    let status_code: Int?
}
