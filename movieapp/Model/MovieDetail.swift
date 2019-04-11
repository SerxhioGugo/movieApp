//
//  MovieDetail.swift
//  movieapp
//
//  Created by Serxhio Gugo on 4/1/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let status, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let videos: Videos?
    let credits: Credits?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres, homepage, id
        case imdbID = "imdb_id"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case status, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos, credits
    }
}

struct Credits: Codable {
    let cast: [Cast]?
}

struct Cast: Codable {
    let castID: Int?
    let character, creditID: String?
    let gender, id: Int?
    let name: String?
    let order: Int?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}
struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct Videos: Codable {
    let results: [VideoResult]?
}

struct VideoResult: Codable {
    let id: String?
    let key, name: String?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case key, name, size
    }
}

