//
//  Movies.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 21/09/23.
//

import Foundation

struct MoviesResponses: Codable {
    var page: Int
    var totalPage: Int
    var totalResult: Int
    var movies: [MoviesObject]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPage = "total_pages"
        case totalResult = "total_results"
        case movies = "results"
    }
    
}


struct MoviesObject: Codable {
    var title: String
    var releaseDate: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case imageUrl = "poster_path"
    }

}
