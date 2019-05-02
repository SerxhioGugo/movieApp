//
//  Genre.swift
//  movieapp
//
//  Created by Serxhio Gugo on 5/2/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let genres: [GenreList]
}

struct GenreList: Codable {
    let id: Int?
    let name: String?
}
