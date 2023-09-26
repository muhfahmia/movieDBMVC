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
    var id: Int
    var title: String
    var releaseDate: String
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case imageUrl = "poster_path"
    }

}

struct MoviesDetailResponse: Codable {
    var title: String
    var imageUrl: String
    var description: String
    var genres: [MoviesGenres]

    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "backdrop_path"
        case description = "overview"
        case genres
    }
    
}


struct MoviesGenres: Codable {
    var id: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}


