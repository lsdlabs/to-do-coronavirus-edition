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

    private let apiKey = ""
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Helpers.jsonDecoder

    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        //TO-DO: add method body/implementation
        guard let url = URL(string: "\(baseAPIURL)/search/movie") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        self.decodeDataFromURL(url: url, parameters: ["query": query], completion: completion)
    }
    
    // https://github.com/raywenderlich/swift-style-guide#generics
    // For the T result, is there a meaningful relationship or role that would help give it a name?
    // Maybe for this, T could be called something like "Response"? as it will always be response data from a URL?
    
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

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                //TO-DO: implement error
                return
            }

            guard let data = data else {
                //TO-DO: implement error
                return
            }

            do {
                let decodedResponse = try self.jsonDecoder.decode(Response.self, from: data)
                //TO-DO: implement success
            } catch {
                //TO-DO: implement error
            }
        }.resume()
    }
}
