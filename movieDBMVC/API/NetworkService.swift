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
    
    func getImageFromSDWeb(withUrl url: String, imageView image: UIImageView) -> Void {
        image.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w200/"+url))
    }
    
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
    
        func getDetailMovies(detailID id: String = "", result: @escaping (Result<MoviesDetailResponse, URLError>) -> Void) {
            guard let url = URL(string: APIConfig.baseUrl+"movie/"+id)
            
            else { return }
            
            let param = [
                "api_key": APIConfig.apiKey
            ]
            
            AF.request(url, method: .get,parameters: param)
            .validate()
            .responseDecodable(of: MoviesDetailResponse.self) {
                response in
                switch response.result {
                case .success(let data):
                    let resultList = data
                    result(.success(resultList))
                case .failure(let error): print("error Alamofire: \(error)")
                }
            }
        }
}
    
