//
//  MovieStore.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 10/11/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import Foundation
//MovieStore: concrete class that will implement the MovieService

class MovieStore: MovieService {
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "8d350c8f38888182efa6a31b35171f21"
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Helpers.jsonDecoder
    
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let myURL = URL(string: "\(baseAPIURL)/search/movie/?api_key=\(apiKey)&query=\(encodedQuery)")
        
        guard let url = myURL else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        decodeDataFromURL(url: url, parameters: ["query": query], completion: completion)
    }
    
    private func decodeDataFromURL<Response: Decodable>(url: URL,
                                                        parameters: [String: String]? = nil,
                                                        completion: @escaping (Result<Response, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        if let parameters = parameters {
            queryItems.append(contentsOf: parameters.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let composedURL = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: composedURL) { (data, response, error) in
            
            if error != nil {
                completion(.failure(.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode,
                let data = data else {
                    completion(.failure(.invalidResponse))
                    return
            }
            
            do {
                let decodedResponse = try self.jsonDecoder.decode(Response.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
}
