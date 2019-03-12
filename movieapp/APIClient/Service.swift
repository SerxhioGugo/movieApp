//
//  Service.swift
//  movieapp
//
//  Created by Serxhio Gugo on 3/10/19.
//  Copyright © 2019 Serxhio Gugo. All rights reserved.
//

import UIKit

struct Service {
    
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    
    enum GET {
        case getTopRated
        case getNowPlaying
        case getPopular
        case getUpcoming
        case getKeyForId(id: Int)
        case getIdResponse(id: Int)
        case getCast(id: Int)
        case query(searchTerm: String)
    }
    
    static func requests(_ request: GET) -> URL? {
        let urlString : String
        switch request {
            
        case .getTopRated:
            urlString = Service.baseURL + "top_rated?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getNowPlaying:
            urlString = Service.baseURL + "now_playing?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getPopular:
            urlString = Service.baseURL + "popular?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getUpcoming:
            urlString = Service.baseURL + "upcoming?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getKeyForId(let movieId):
            urlString = Service.baseURL + "\(movieId)" + "/videos?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getIdResponse(let movieId):
            urlString = Service.baseURL + "\(movieId)?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .getCast(let movieId):
            urlString = Service.baseURL + "\(movieId)" + "credits?" + Secrets.API.TheMovieDBKey.apiKey
            
        case .query(let query):
            urlString = "https://api.themoviedb.org/3/search/movie?" + Secrets.API.TheMovieDBKey.apiKey + "&query=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        return URL(string: urlString)
    }
    
    static func fetchJSON<T: Decodable>(url: URL, completion: @escaping (T?, Error?) -> Void) {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("Error fetching data", error)
                completion(nil, error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode > 200 {
                    print("Error with network request: \(httpResponse)")
                    return
                }
            }
            
            guard let data = data else { return }
            do {
                let response = try decoder.decode(T.self, from: data)
                    completion(response, nil)
            } catch {
                print("Error decoding data: ", error)
                completion(nil, error)
            }
        }
        dataTask.resume()
    }
    
}
