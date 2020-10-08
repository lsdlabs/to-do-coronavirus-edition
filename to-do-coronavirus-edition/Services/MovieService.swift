//
//  MovieService.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 10/7/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import Foundation

protocol MovieService {
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData

    var localizedDescription: String {
        switch self {
        case .apiError:
            return "Failed to fetch data"
        case .invalidEndpoint:
            return "Invalid endpoint"
        case .invalidResponse:
            return "Invalid response"
        case .noData:
            return "No data"
        }
    }
}
