//
//  MoviesMapper.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 22/09/23.
//

class MoviesMapper {
    
    static func mapMoviesToDomains(input moviesReponse: [MoviesObject]) -> [MoviesObject] {
        return moviesReponse.map {
            movie in
            return MoviesObject(id: movie.id, title: movie.title, releaseDate: movie.releaseDate, imageUrl: movie.imageUrl)
        }
    }
    
}
