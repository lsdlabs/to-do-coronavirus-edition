//
//  MovieService.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 10/7/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import Foundation
//protocol that represents the API Service
protocol MovieService {
    //searching movies when given a quesry string as a parameter...the parameter also accepts an escaping closure using the Swift Result type. The type of success data is MovieResponse, and for the error, we will use the MovieError enum.
    func searchMovie(query: String, completion: @escaping (Result<MovieResponse, MovieError>) -> ())
}

enum MovieError: Error {
    case apiError //generic error
    case invalidEndpoint //error when constructing the url
    case invalidResponse //error when the status code is not in the range between 200 and 300
    case noData //

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
