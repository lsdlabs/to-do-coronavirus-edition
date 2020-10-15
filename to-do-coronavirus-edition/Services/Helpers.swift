//
//  Helpers.swift
//  to-do-coronavirus-edition
//
//  Created by Lauren Small on 10/11/20.
//  Copyright © 2020 Lauren Small. All rights reserved.
//

import Foundation

class Helpers {

    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
