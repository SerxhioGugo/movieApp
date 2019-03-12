//
//  MovieGroup.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/11/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct MovieGroup: Decodable {
    let results: [MovieResults]
}

struct MovieResults: Decodable {
    let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}
