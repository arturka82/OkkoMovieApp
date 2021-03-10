//
//  Model.swift
//  MovieApp
//
//  Created by Artur Gedakyan on 08.03.2021.
//

import Foundation

/// Movie model
// struct Movie: Decodable {
//    var image: String
//    var name: String
//    var description: String
//    var date: String
// }

/// NewMovie
struct NewMovie: Decodable {
    var id: Int
    var name: String
}

/// MovieModel
struct Movie: Decodable {
    let backdropPath: String?
    let posterPath: String?
    let originalTitle: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(
            keyedBy:
            CodingKeys.self
        )
        backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        voteCount = try? container.decode(Int.self, forKey: .voteCount)
        overview = try? container.decode(String.self, forKey: .overview)
    }
}

/// Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

/// ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
