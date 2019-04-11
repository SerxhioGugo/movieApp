//
//  Search.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/11/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

struct Search: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let posterPath: String?
    let id: Int
}
