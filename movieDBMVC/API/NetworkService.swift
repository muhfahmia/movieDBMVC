//
//  NetworkService.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 21/09/23.
//

import Foundation
import Alamofire
import SDWebImage

class NetworkService {
    private init() {}
    
    static let sharedService = NetworkService()
    
    func getMovies(typeMovies type: String = "", result: @escaping (Result<[MoviesObject], URLError>) -> Void) {
        guard let url = URL(string: type)
        
        else { return }
        
        let param = [
            "api_key": APIConfig.apiKey
        ]
        
        AF.request(url, method: .get,parameters: param)
            .validate()
            .responseDecodable(of: MoviesResponses.self) {
                response in
                switch response.result {
                case .success(let data):
                    let resultList = MoviesMapper.mapMoviesToDomains(input: data.movies)
                    result(.success(resultList))
                case .failure(let error): print("error Alamofire: \(error)")
                }
            }
    }
}
    
