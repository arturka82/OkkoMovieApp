//
//  MovieRequest.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 10.03.2021.
//

import Foundation

/// MovieRequest
struct MovieRequest: Decodable {
    var movieArray: [Movie]

    enum CodingKeys: String, CodingKey {
        case movieArray = "results"
    }
}
