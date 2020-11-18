//
//  Movie.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 10/7/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Hashable, Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let runtime: Int?
}
