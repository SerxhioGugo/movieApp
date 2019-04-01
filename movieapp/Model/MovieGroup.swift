//
//  MovieGroup.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/11/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct MovieGroup: Decodable {
    var results: [MovieResults]
}

struct MovieResults: Decodable {
    let posterPath: String?
    let title: String?
    let backdropPath: String?
    let releaseDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
