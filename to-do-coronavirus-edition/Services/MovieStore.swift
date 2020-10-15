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
    }

    private func decodeDataFromURL<T: Decodable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<T, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
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
        }
    }
}
